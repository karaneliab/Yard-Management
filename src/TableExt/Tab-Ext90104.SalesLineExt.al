namespace YardManagement.YardManagement;

using Microsoft.Sales.Document;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Sales.History;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Team;

tableextension 90104 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(90100; Make; Text[40])
        {
            Caption = 'Make';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90101; "CommissionPac"; Decimal)
        {
            Caption = '% Commission';
            Editable = false;
            // DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(90102; AcquisitionCost; Decimal)
        {
            Caption = 'Acquisition Cost';
            //  FieldClass = FlowField;
            Editable = false;
            // CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = FIELD("No."),
            //                                                   "Depreciation Book Code" = FIELD("FA Location Code")));
            // CalcFormula = lookup(Microsoft.Purchases.History."Purch. Inv. Line"."Direct Unit Cost" WHERE("No." = field("No.")));
            // CalcFormula = lookup("Fixed Asset".AcquisitionCost WHERE("No." = FIELD("No.")));

        }
        field(90103; Employee; Text[250])
        {
            Caption = 'Employee';
            DataClassification = ToBeClassified;
        }

        field(90104; SalesPerson; Text[250])
        {
            Caption = 'SalesPerson';
            DataClassification = ToBeClassified;
        }
        field(90105; Commission; Decimal)
        {
            Caption = 'Commission Amount';
            Editable = false;
            trigger OnValidate()
            begin
                CommisionCalculate()
            end;

        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                FA: Record "Fixed Asset";
                CommissionRate: Record "Commission Rate";
                FADepreciationBook: Record "FA Depreciation Book";
            begin
                if Type = Type::"Fixed Asset" then begin
                    if FA.get("No.") then begin
                        if CommissionRate.Get(FA."Car Make") then
                            "CommissionPac" := CommissionRate."Commission Rate";
                        Make := FA."Car Make";
                        AcquisitionCost := FA.AcquisitionCost;
                        FADepreciationBook.Reset();
                        FADepreciationBook.SetRange("FA No.", FA."No.");
                        if FADepreciationBook.FindFirst() then begin
                            FADepreciationBook.CalcFields("Book Value");
                            AcquisitionCost := FADepreciationBook."Book Value";
                        end;
                        Validate("CommissionPac");
                        
                    end;
                end;

            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                CommisionCalculate(); 
            end;
        }
    }

    procedure CommisionCalculate()
    var
        CarMakeCommission: Record "Commission Rate";
        FixedAsset: Record "Fixed Asset";
        Profit, CommissionAmount: Decimal;
    begin
        // Fetch the acquisition cost from the Fixed Asset table based on the "No." field in Sales Line
        if FixedAsset.Get("No.") then begin
            AcquisitionCost := FixedAsset.AcquisitionCost;

            if CarMakeCommission.Get(Make) then begin
                "CommissionPac" := CarMakeCommission."Commission Rate";

                // Calculate the profit (Unit Price - Acquisition Cost)
                Profit := "Unit Price" - AcquisitionCost;

                // Ensure the profit is positive before calculating commission
                if Profit > 0 then
                    CommissionAmount := CalculateCommissionAmount("CommissionPac", Profit)
                else
                    CommissionAmount := 0;

                Commission := CommissionAmount;
            end else begin
                "CommissionPac" := 0; 
                Commission := 0;
            end;
        end else begin
            Error('Fixed Asset not found for the given No.');
        end;
    end;

    procedure CalculateCommissionAmount("CommissionPac": Decimal; Profit: Decimal): Decimal
    begin
        // Calculate the commission amount based on the percentage and profit
        exit((Profit * ("CommissionPac" / 100)));
    end;

}
