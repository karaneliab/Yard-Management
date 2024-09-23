namespace Microsoft.Sales.Customer;

using System.Automation;
using Microsoft.Sales.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Foundation.NoSeries;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.FixedAsset;

table 90110 "Car Recieving Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "recieving List";
    LookupPageId = "recieving List";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnLookup()
            begin
                TestNoSeries();

            end;

        }

        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

        }
        field(7; Description; Text[250])
        {
            Caption = 'Car Receiving Description';
            DataClassification = AccountData;
            

        }
        field(10; "Buying Price"; Decimal)
        {
            Caption = 'Buying Price';
            DataClassification = CustomerContent;
            // FieldClass = FlowField;
            // // CalcFormula = lookup(Microsoft.Sales.Document."Sales Line"."Unit Price" where("No." = field("Customer Nos.")));
            // // CalcFormula = lookup(Microsoft.Purchases.Document."Purchase Line".Amount where ("No." = field("Customer Nos.")));
            // CalcFormula = Sum("Purchase Line"."Direct Unit Cost" where ("No." = field("FA No.")));
            

        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }


        field(5; "Status"; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                TestOnRelease();
            end;
        }
        field(9; "Customer Nos."; Code[20])
        {
            Caption = 'Customer Nos.';
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }
        field(6; "Last Released Date"; DateTime)
        {
            Caption = 'Last Released Date';
            DataClassification = CustomerContent;
            Editable = false;

        }
         field(11; "FA No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            TableRelation = "Fixed Asset";
        }
    }

    local procedure TestStatus()
    begin
        if Status <> Status::"Approved" then
            exit;

        "Last Released Date" := CurrentDateTime;
    end;

    local procedure TestOnRelease()
    begin
        if Status <> Status::Approved then
            exit;
        // TestField("Customer No.");
        "Last Released Date" := CurrentDateTime;
    end;

    local procedure TestNoSeries()
    var
        CarReceived: Record "Car Recieving Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestNoSeries(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "No" <> xRec."No" then
            if not CarReceived.Get(Rec."No") then begin
                SalesSetup.Get();
                NoSeries.TestManual(SalesSetup."Customer Nos.");
                "No. Series" := '';
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var Customer: Record "Car Recieving Header"; xCustomer: Record "Car Recieving Header"; var IsHandled: Boolean)
    begin
    end;


    var

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";

    trigger OnInsert()
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Customer Nos.");
        IF No = '' then
            No := NoSeries.GetNextNo(SalesSetup."Customer Nos.")

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure PostCarDetails(var Header: Record "Car Recieving Header")
    var
        CarHeader: Record "Car Recieving Header";
        FixedAsset: Record "Fixed Asset";
        CarLine: Record "Car Line";
        FADepreciationBook: Record "FA Depreciation Book";
        ExistingFixedAsset: Record "Fixed Asset";
        PurchaseLine: Record "Purchase Line";


    begin
        // Posting logic here
        CarLine.Reset();
        CarLine.SetRange("Document No.", Header.No);
        if CarLine.FindSet() then begin
            repeat
                if CarLine."Car Make" = '' then
                    Error('Enter the car make details');
                if CarLine."Car Model" = '' then
                    Error('Enter the car model details');
                if CarLine."Chassis Number" = '' then
                    Error('Enter the chasis number');
                if CarLine.RegNo = '' then
                    Error('Fill in the registration field');
                if CarLine."Country Of Registration" = '' then
                    Error('Enter the country of registration ');
                if CarLine."FA Class Code" = '' then
                    Error('Enter the Fa class code to get correct subclass with default posting group');
                ExistingFixedAsset.Reset();
                ExistingFixedAsset.SetRange(ExistingFixedAsset."RegNo", CarLine.RegNo);
                if ExistingFixedAsset.FindFirst() then
                    Error('A car with the registration number %1 already exists.', CarLine.RegNo);
                FixedAsset.Init();
                FixedAsset.ChassisNo := CarLine."Chassis Number";
                FixedAsset."Car Make" := CarLine."Car Make";
                FixedAsset."Description" := CarLine.RegNo;
                FixedAsset."Model" := CarLine."Car Model";
                FixedAsset."RegNo" := CarLine.RegNo;
                FixedAsset."Year of Manufacture" := CarLine."Year of Make";
                FixedAsset."Country Of First Registration" := CarLine."Country Of Registration";
                FixedAsset."FA Location Code" := CarLine.YardBranch;
                FixedAsset."Insuarance Company" := CarLine."Insurance Company";
                FixedAsset."FA Class Code" := CarLine."FA Class Code";
                FixedAsset."Vendor No." := CarLine."Received From";
                FixedAsset."FA Subclass Code" := CarLine."FA Subclass Code";
                FixedAsset.Validate("Car Insured",CarLine."Car Insured");
                FixedAsset.Insert(true);
                CarLine."FA No" := FixedAsset."No.";
                 
               
                FADepreciationBook.Init();
                FADepreciationBook.Validate("Depreciation Book Code",CarLine."Depreciation Book");
                FADepreciationBook.Validate("Depreciation Starting Date",CarLine."Depreciation Starting Date");
                FADepreciationBook.Validate("Depreciation Ending Date",CarLine."Depreciation Ending Date");
                FADepreciationBook.Validate("No. of Depreciation Years",CarLine."No of Depreciation Years");
                FADepreciationBook.Validate("FA Posting Group",CarLine."FA Posting Group");
                FADepreciationBook.Validate("FA No.",CarLine."FA No");
                FADepreciationBook.Insert(true);


            until CarLine.Next() = 0;
        end;



    end;
    //  procedure CommisionCalculate(var Header: Record "Car Recieving Header")
    // var
    //     CarReceivingHeader: Record "Car Recieving Header";
    //     CommissionRate: Decimal;
    //     CarLine: Record "Car Line";
    //     CarMakeCommission: Record "Commission Rate";
    //     BuyingPrice: Decimal;
    // begin
    //     CarLine.Reset();
    //     if CarReceivingHeader.Get(Rec.CarReceivingHeader."Document No.") then begin
    //         BuyingPrice := CarReceivingHeader."Buying Price";

            
    //         if CarMakeCommission.Get(Rec."Car Make") then begin
    //             CommissionRate := CarMakeCommission."Commission Rate";

                
    //             CarLine."Commission Amount" := CalculateCommissionAmount(CommissionRate, BuyingPrice);
    //         end;
    //     end;
    // end;

    // procedure CalculateCommissionAmount(CommissionRate: Decimal; BuyingPrice: Decimal): Decimal
    // begin
    //     exit((BuyingPrice * CommissionRate) / 100); 
    // end;

}