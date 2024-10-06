table 90111 "Car Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Car Recieving Header";
            Caption = 'Document No';

        }
        field(2; CarNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Fixed asset Number';
            TableRelation = "Fixed Asset";
            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
            begin
                // Fetch the Fixed Asset record based on the selected Registration Number
                if FixedAsset.Get(CarNo) then begin
                    "Car Make" := FixedAsset."Car Make";
                    "Car Model" := FixedAsset.Model;
                    "Chassis Number" := FixedAsset.ChassisNo;
                     RegNo := FixedAsset.RegNo;
                     YardBranch := FixedAsset."FA Location Code";
                end else begin
                    "Car Make" := '';
                    "Car Model" := '';
                    "Chassis Number" := '';
                    RegNo := '';
                    YardBranch := '';
                end;
            end;

        }
        field(30;RegNo;code[20])
        {
             DataClassification = CustomerContent;
            Caption = 'RegNo';
            TableRelation = "Fixed Asset";
        }
        field(3; "Checked In By"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Checked in by.';
            TableRelation = Employee;
            trigger OnValidate()
            begin
                EmployeeStatus();
            end;

        }
        field(4; YardBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Yard Branch';
            TableRelation = "Fixed Asset"."FA Location Code";
        }

        field(6; "Received From"; Text[40])
        {
            Caption = 'Received From';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(7; "Car Make"; Text[250])
        {
            Caption = 'Car Make';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset" where("Car Make" = field("Car Make"));
            // var
            //     RecordHasBeenRead: Boolean;

            // procedure GetRecordOnce()
            // begin
            //     if RecordHasBeenRead then
            //         exit;
            //     Get();
            //     RecordHasBeenRead := true;
            // end;
        }
        field(8; "Car Model"; Text[40])
        {
            Caption = 'Car Model';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset" where(Model = field("Car Model"));
        }
        field(9; "Chassis Number"; Text[40])
        {
            Caption = 'Chasis Number';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset";
        }
        field(10; "Country Of Registration"; Text[250])
        {
            Caption = 'Country Of Registration';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }

        field(11; "FA Posting Group"; Code[20])
        {
            Caption = 'FA posting group';
            DataClassification = CustomerContent;
            TableRelation = "FA Posting Group";
        }
        field(21; "No."; Code[20])
        {
            Caption = 'Customer No';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset";
            
            trigger OnValidate()
            begin
                TestStatus();
                CalcFields("Depreciation Book");
            end;
        }

        field(12; "Depreciation Book"; Boolean)
        {
            Caption = 'Depreciation Book';
            // DataClassification = Normal;
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("FA Depreciation Book" where("FA No." = field("No."),
                                                              "Acquisition Date" = filter(<> 0D)));
        }
        field(91; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

  
        }
        field(22; "VAT Bussuness Posting Group"; Code[20])
        {
            Caption = ' VAT Business Posting Group';
            TableRelation = "VAT Business Posting Group";

        }
        field(24; "Tax Code"; Code[20])
        {
            Caption = 'Tax Code';
            TableRelation = "Tax Group";
        }

    }
    keys
    {
        key(ki; RegNo, "Document No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TestStatus();
    end;

    trigger OnModify()
    begin
        TestStatus();

    end;

    trigger OnDelete()
    begin
        TestStatus();
    end;

    trigger OnRename()
    begin
        TestStatus();

    end;

    var
        StatusCannotBeReleasedErr: Label 'status cannot be %1 .', comment = '%1 -  status field value';
        EmployeeStatusErr: Label 'The Employee Is.', Comment = '%1 - status field  value';

    local procedure TestStatus()
    var
        CarHeader: Record "Car Recieving Header";
    begin
        if CarHeader.Get(Rec."Document No.") then
            if CarHeader.Status = CarHeader.Status::"Approved" then
                Error(StatusCannotBeReleasedErr, CarHeader.Status);
    end;

    local procedure EmployeeStatus()
    var
        EmployeeStatus: Record "Employee";
    begin
        if EmployeeStatus.Get(Rec."Document No.") then
            if EmployeeStatus.Status = EmployeeStatus.Status::"Inactive" then
                Error(EmployeeStatusErr, EmployeeStatus.Status);
    end;

    local procedure ProdOrderExist(): Boolean
    begin
        ProdOrderLine.SetCurrentKey(Status, "Item No.");
        ProdOrderLine.SetFilter(Status, '..%1', ProdOrderLine.Status::Released);
        ProdOrderLine.SetRange("Item No.", "No.");
        if not ProdOrderLine.IsEmpty() then
            exit(true);

        exit(false);
    end;

    var
        ProdOrderLine: Record "Prod. Order Line";
        Text022: Label 'Do you want to change %1?';
        GLSetup: Record "General Ledger Setup";

        Text023: Label 'You cannot delete %1 %2 because there is at least one %3 that includes this item.';
        Text024: Label 'If you change %1 it may affect existing production orders.\';
        GenProdPostingGrp: Record "Gen. Product Posting Group";
}
   //     if CarReceivingHeader.Get(Rec."Document No.") then begin
    //          Profit := CarReceivingHeader."Profit";


    //         if CarMakeCommission.Get(Rec."Make") then begin
    //             CommissionRate := CarMakeCommission."Commission Rate";


    //             "Commission Amount" := CalculateCommissionAmount(CommissionRate,  Profit);
    //         end;
    // 

  
<!--   ##############################################################################################################
     // local procedure CalculateJournalLineCommission(GenJournalLine: Record "Gen. Journal Line"): Decimal
    // var
    //     CarMakeCommission: Record "Commission Rate";
    //     FixedAsset: Record "Fixed Asset";
    //     Profit, CommissionAmount, AcquisitionCost : Decimal;
    // begin

    //     // if FixedAsset.Get(GenJournalLine."Account Type"::"Fixed Asset") then begin

    //     //     AcquisitionCost := FixedAsset.AcquisitionCost;
    //     if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset" then begin
           
    //         if FixedAsset.Get(GenJournalLine."Line No.") then begin


    //             if CarMakeCommission.Get(FixedAsset."Car Make") then begin

    //                 Profit := GenJournalLine.Amount - AcquisitionCost;

    //                 // Ensure the profit is positive before calculating commission
    //                 if Profit > 0 then
    //                     CommissionAmount := Profit * (CarMakeCommission."Commission Rate" / 100)
    //                 else
    //                     CommissionAmount := 0;
    //             end else begin
    //                 // If no commission rate is found, set commission to 0
    //                 CommissionAmount := 0;
    //             end;
    //         end else begin
    //             // If the Fixed Asset record is not found, raise an error or return zero commission
    //             Error('Fixed Asset not found for the given FA No.');
    //         end;

    //         // Return the calculated commission amount
    //         exit(CommissionAmount);
    //     end;
    // end;

    local procedure CalculateJournalLineCommission(GenJournalLine: Record "Gen. Journal Line"): Decimal
var
    CarMakeCommission: Record "Commission Rate";
    FixedAsset: Record "Fixed Asset";
    Profit, CommissionAmount, AcquisitionCost: Decimal;
    CommissionPac: Decimal;
begin
    // Check if the Account Type is Fixed Asset
    if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset" then begin
        // Fetch the Fixed Asset using the FA No. from the journal line
        if FixedAsset.Get(GenJournalLine."Line No.") then begin
            AcquisitionCost := FixedAsset.AcquisitionCost;

            // Retrieve the commission percentage based on the car make from the Fixed Asset record
            if CarMakeCommission.Get(FixedAsset."Car Make") then begin
                CommissionPac := CarMakeCommission."Commission Rate";
                
                // Calculate the profit (Journal Line Amount - Acquisition Cost)
                Profit := GenJournalLine.Amount - AcquisitionCost;

                // Ensure the profit is positive before calculating commission
                if Profit > 0 then
                    CommissionAmount := CalculateCommissionAmount(CommissionPac, Profit)
                else
                    CommissionAmount := 0;
            end else begin
                // If no commission rate is found, set commission to 0
                CommissionAmount := 0;
            end;
        end else begin
            Error('Fixed Asset not found for the given FA No.');
        end;
    end else begin
        // If Account Type is not Fixed Asset, set commission to 0
        CommissionAmount := 0;
    end;

    // Return the calculated commission amount
    exit(CommissionAmount);
end;
    //  procedure CalculateCommissionAmount("CommissionPac": Decimal; Profit: Decimal): Decimal
    // begin
    //     // Calculate the commission amount based on the percentage and profit
    //     exit((Profit * ("CommissionPac" / 100)));
    // end;

procedure CalculateCommissionAmount(CommissionPac: Decimal; Profit: Decimal): Decimal
begin
    // Calculate the commission amount based on the percentage and profit
    exit(Profit * (CommissionPac / 100));
end;
###############################################!?################################################################33 -->
// procedure RaisePurchaseInv(var Header: Record "Car Recieving Header"; VendorNo: Code[20])
// var
//     PurchaseHeader: Record "Purchase Header";
//     PurchaseLine: Record "Purchase Line";
//     CarLine: Record "Car Line";
//     LineNo: Integer; 
//     Vendor: Record Vendor;

// begin
    
//     PurchaseHeader.Init();
//     PurchaseHeader."Buy-from Vendor No." := VendorNo; 
//     // PurchaseHeader."Buy-from Vendor Name" := Vendor.Name;
//      if Vendor.Get(VendorNo) then
//         PurchaseHeader."Buy-from Vendor Name" := Vendor.Name;
//     PurchaseHeader."Posting Date" := Header."Date"; 
//     PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice; 

    
//     PurchaseHeader.Insert(true); 

  
//     CarLine.Reset();
//     CarLine.SetRange("Document No.", Header.No);

//     if CarLine.FindSet() then begin
//         LineNo := 0; 
//         repeat
            
//             PurchaseLine.Init();
//             PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice; 
//             PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
//             PurchaseLine."Document No." := CarLine."FA No"; 
            
            
//             LineNo += 10000; 
//             PurchaseLine."Line No." := LineNo;

//             PurchaseLine."No.":= CarLine."FA No"; 
//             PurchaseLine."Quantity" := 1; 
//             // PurchaseLine."Unit Cost" := CarLine."Acquisition Cost"; 
//             PurchaseLine."Description" := CarLine."Chassis Number"; 
           
//             PurchaseLine.Insert(true);

//         until CarLine.Next() = 0;
//     end;
// end;



// procedure RaisePurchaseInv(var Header: Record "Car Recieving Header"; VendorNo: Code[20])
// var
//     PurchaseHeader: Record "Purchase Header";
//     PurchaseLine: Record "Purchase Line";
//     CarLine: Record "Car Line";
//     LineNo: Integer; 
//     Vendor: Record Vendor;
//     FixedAsset: Record "Fixed Asset";
// begin
//     PurchaseHeader.Init();
//     PurchaseHeader."Buy-from Vendor No." := VendorNo; 
    
//     if Vendor.Get(VendorNo) then
//         PurchaseHeader.VALIDATE("Buy-from Vendor Name", Vendor.Name);
    
//     PurchaseHeader."Posting Date" := Header."Date"; 
//     // PurchaseHeader."Vendor Invoice No." := VendorNo;
//     PurchaseHeader.VALIDATE("Vendor Invoice No.",VendorNo);
//     PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice; 
//     // PurchaseLine."No." := CarLine."FA No"; 
//      // PurchaseLine."Document No." := PurchaseHeader."No.";
//     PurchaseHeader.Insert(TRUE); 
//     CarLine.Reset();
//     CarLine.SetRange("Document No.", Header.No);

//     if CarLine.FindSet() then begin
//         LineNo := 0; 
//         repeat
//             PurchaseLine.Init();
//             PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice; 
//             PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
//             // PurchaseLine."Document No." := CarLine."FA No"; 
//             PurchaseLine."Document No." := PurchaseHeader."No.";
//             LineNo += 10000; 
//             PurchaseLine."Line No." := LineNo;

//             // PurchaseLine."No." := CarLine."FA No"; 
           
//             PurchaseLine."Quantity" := 1; 
            
//             // PurchaseLine."Unit Cost" := CarLine."Acquisition Cost"; 
//             // PurchaseLine."Description" := CarLine."Chassis Number"; 
//             PurchaseLine.Validate(Description,CarLine."Chassis Number");
//             PurchaseLine.Insert(TRUE);

//         until CarLine.Next() = 0;
//     end;
// end;