namespace Microsoft.Sales.Customer;

using System.Automation;
using Microsoft.Sales.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Foundation.NoSeries;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Setup;
using Microsoft.FixedAssets.Setup;
using Microsoft.Purchases.Vendor;

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

            trigger OnValidate()
            begin
                // TestNoSeries();
                if "No" <> xRec."No" THEN begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Car Receiving Nos.");
                    "No. Series" := '';
                end;

            end;

        }

        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
            // DataClassification = AccountData;
            DataClassification = CustomerContent;


        }
        // field(10; "Buying Price"; Decimal)
        // {
        //     Caption = 'Buying Price';
        //     DataClassification = CustomerContent;
        //     // FieldClass = FlowField;
        //     // // CalcFormula = lookup(Microsoft.Sales.Document."Sales Line"."Unit Price" where("No." = field("Customer Nos.")));
        //     // // CalcFormula = lookup(Microsoft.Purchases.Document."Purchase Line".Amount where ("No." = field("Customer Nos.")));
        //     // CalcFormula = Sum("Purchase Line"."Direct Unit Cost" where ("No." = field("FA No.")));


        // }
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
        field(4; YardBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Yard Branch';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
            CaptionClass = '1,1,3';

        }
        field(31; "Buying Price"; Decimal)
        {
            Caption = 'Buying Price';
            FieldClass = FlowField;
            // CalcFormula = lookup("Car Line"."Buying Price" where("Document No." =FIELD(No)));
            CalcFormula = sum("Car Line"."Buying Price" where("Document No." = FIELD(No)));
            // trigger OnLookup()
            // var 
            //  CarLine: Record "Car Line";
            //  begin
            //     CarLine.Reset();
            //     CarLine.SetRange("Document No.", "No");
            //     if CarLine.FindFirst() then begin
            //         "Buying Price" := CarLine."Buying Price";
            //     end;
            //  end;

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

        "Last Released Date" := CurrentDateTime;
    end;

    // local procedure TestNoSeries()
    // var
    //     CarReceived: Record "Car Recieving Header";
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     OnBeforeTestNoSeries(Rec, xRec, IsHandled);
    //     if IsHandled then
    //         exit;

    //     if "No" <> xRec."No" then
    //         if not CarReceived.Get(Rec."No") then begin
    //             SalesSetup.Get();
    //             NoSeries.TestManual(SalesSetup."Customer Nos.");
    //             "No. Series" := '';
    //         end;
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var Customer: Record "Car Recieving Header"; xCustomer: Record "Car Recieving Header"; var IsHandled: Boolean)
    begin
    end;


    var

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";

    // trigger OnInsert()
    // begin
    //     SalesSetup.Get();
    //     SalesSetup.TestField("Customer Nos.");
    //     IF No = '' then
    //         No := NoSeries.GetNextNo(SalesSetup."Customer Nos.")

    // end;
    trigger OnInsert()
    begin
        if "No" = '' then
            PurchSetup.Get();
        PurchSetup.TestField("Car Receiving Nos.");
        NoSeriesMgt.InitSeries(PurchSetup."Car Receiving Nos.", xRec."No. Series", 0D, "No", "No. Series");


    end;

    var
        PurchSetup: Record Microsoft.Purchases.Setup."Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    // procedure PostCarDetails(var Header: Record "Car Recieving Header")
    // var
    //     CarHeader: Record "Car Recieving Header";
    //     FixedAsset: Record "Fixed Asset";
    //     CarLine: Record "Car Line";
    //     FADepreciationBook: Record "FA Depreciation Book";
    //     ExistingFixedAsset: Record "Fixed Asset";
    //     PurchaseLine: Record "Purchase Line";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     PurchSetup: Record "Purchases & Payables Setup";
    //     FASetup: Record "FA Setup";


    // begin
    //     // Posting logic here
    //     FASetup.Get();
    //     CarLine.Reset();
    //     CarLine.SetRange("Document No.", Header.No);
    //     if CarLine.FindSet() then begin
    //         repeat
    //             if CarLine."Car Make" = '' then
    //                 Error('Enter the car make details');
    //             if CarLine."Car Model" = '' then
    //                 Error('Enter the car model details');
    //             if CarLine."Chassis Number" = '' then
    //                 Error('Enter the chasis number');

    //             if CarLine."Country Of Registration" = '' then
    //                 Error('Enter the country of registration ');
    //             if CarLine."Checked In By" = '' then
    //                 Error('Enter the checked in by field');
    //             if CarLine."FA Class Code" = '' then
    //                 Error('Enter the Fa class code to get correct subclass with default posting group');
    //                 FixedAsset.Init();
    // //                 //  NoSeriesMgt.InitSeries(PurchSetup."FA Nos", '', 0D, FixedAsset."No.", CarLine."FA No");
    // //                 // NoSeriesMgt.InitSeries(FASetup."Fixed Asset Nos.", '', 0D, FixedAsset."No.", CarLine."FA No");
    // CarLine."FA No" := NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.", CarHeader."Date", true);
    //                 // CarLine."FA No" := NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.", CarHeader."Date", true);
    //                  CarLine."FA No" := FixedAsset."No.";

    //                 //  NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.",  0D,TRUE);
    //                 //  
    //                 //  CarLine."FA No" := NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.", CarHeader."Date", true);


    //                 FixedAsset.ChassisNo := CarLine."Chassis Number";
    //                 FixedAsset."Car Make" := CarLine."Car Make";
    //                 FixedAsset."Description" := CarLine."Chassis Number";
    //                 FixedAsset."Model" := CarLine."Car Model";
    //                 FixedAsset."RegNo" := CarLine.RegNo;
    //                 FixedAsset."Responsible Employee" := CarLine."Checked In By";
    //                 FixedAsset."Year of Manufacture" := CarLine."Year of Make";
    //                 FixedAsset."Country Of First Registration" := CarLine."Country Of Registration";
    //                 FixedAsset."FA Location Code" := CarLine.YardBranch;
    //                 FixedAsset."Insurance Company" := CarLine."Insurance Company";
    //                 FixedAsset."FA Class Code" := CarLine."FA Class Code";
    //                 FixedAsset."Vendor No." := CarLine."Received From";
    //                 FixedAsset."FA Subclass Code" := CarLine."FA Subclass Code";
    //                 FixedAsset.Validate("Car Insured", CarLine."Car Insured");
    //                 FixedAsset.Insert();
    //                 CarLine."FA No" := FixedAsset."No.";
    //                 CarLine.Modify(true);



    //                 // CarLine.Modify(true);

    //                 FADepreciationBook.Init();
    //                 FADepreciationBook.Validate("Depreciation Book Code", CarLine."Depreciation Book");
    //                 FADepreciationBook.Validate("Depreciation Starting Date", CarLine."Depreciation Starting Date");
    //                 FADepreciationBook.Validate("Depreciation Ending Date", CarLine."Depreciation Ending Date");
    //                 FADepreciationBook.Validate("No. of Depreciation Years", CarLine."No of Depreciation Years");
    //                 FADepreciationBook.Validate("FA Posting Group", CarLine."FA Posting Group");
    //                 FADepreciationBook.Validate("FA No.", CarLine."FA No");
    //                 FADepreciationBook.Insert(true);


    //         until CarLine.Next() = 0;
    //             end;




    // end;
    procedure PostCarDetails(var Header: Record "Car Recieving Header")
    var
        CarHeader: Record "Car Recieving Header";
        FixedAsset: Record "Fixed Asset";
        CarLine: Record "Car Line";
        FADepreciationBook: Record "FA Depreciation Book";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FASetup: Record "FA Setup";
        NextFANo: Code[20];

    begin
        // Get FA Setup
        FASetup.Get();
        CarLine.Reset();
        CarLine.SetRange("Document No.", Header.No);

        if CarLine.FindSet() then begin
            repeat
                if CarLine."Car Make" = '' then
                    Error('Enter the car make details');
                if CarLine."Car Model" = '' then
                    Error('Enter the car model details');
                if CarLine."Chassis Number" = '' then
                    Error('Enter the chassis number');
                if CarLine."Country Of Registration" = '' then
                    Error('Enter the country of registration');
                if CarLine."Checked In By" = '' then
                    Error('Enter the checked-in by field');
                if CarLine."FA Class Code" = '' then
                    Error('Enter the FA class code to get the correct subclass with default posting group');


                NextFANo := NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.", Header."Date", true);
                CarLine."FA No" := NextFANo;
                FixedAsset.Init();
                FixedAsset."No." := CarLine."FA No";
                FixedAsset.ChassisNo := CarLine."Chassis Number";
                FixedAsset."Car Make" := CarLine."Car Make";
                FixedAsset."Description" := CarLine."Chassis Number";
                FixedAsset."Model" := CarLine."Car Model";
                FixedAsset."RegNo" := CarLine.RegNo;
                FixedAsset."Responsible Employee" := CarLine."Checked In By";
                FixedAsset."Year of Manufacture" := CarLine."Year of Make";
                FixedAsset."Country Of First Registration" := CarLine."Country Of Registration";
                FixedAsset."FA Location Code" := CarLine.YardBranch;
                FixedAsset."Insurance Company" := CarLine."Insurance Company";
                FixedAsset."FA Class Code" := CarLine."FA Class Code";
                FixedAsset."Vendor No." := CarLine."Received From";
                FixedAsset."FA Subclass Code" := CarLine."FA Subclass Code";
                FixedAsset.Validate("Car Insured", CarLine."Car Insured");


                FixedAsset.Insert();

                CarLine.Modify(true);

                FADepreciationBook.Init();
                FADepreciationBook.Validate("Depreciation Book Code", CarLine."Depreciation Book");
                FADepreciationBook.Validate("Depreciation Starting Date", CarLine."Depreciation Starting Date");
                FADepreciationBook.Validate("Depreciation Ending Date", CarLine."Depreciation Ending Date");
                FADepreciationBook.Validate("No. of Depreciation Years", CarLine."No of Depreciation Years");
                FADepreciationBook.Validate("FA Posting Group", CarLine."FA Posting Group");
                FADepreciationBook.Validate("FA No.", CarLine."FA No");
                FADepreciationBook.Insert(true);

            until CarLine.Next() = 0;
        end;
        // RaisePurchaseInv(Header, FixedAsset."Vendor No.");
    end;




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
    //     PurchaseHeader.Validate("Buy-from Vendor No.");
    //     // PurchaseHeader."Buy-from Vendor Name" := Vendor.Name;
    //     PurchaseHeader."Posting Date" := Header."Date"; 
    //     PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice; 
    //      PurchaseHeader.VALIDATE("Vendor Invoice No.",Header.No);

    //     PurchaseHeader.Insert(true); 


    //     CarLine.Reset();
    //     CarLine.SetRange("Document No.", Header.No);

    //     if CarLine.FindSet() then begin
    //         LineNo := 0; 
    //         repeat

    //             PurchaseLine.Init();
    //             PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice; 
    //             PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
    //             // PurchaseLine."Document No." :=PurchaseHeader."No."; 
    //             PurchaseLine.Validate("Document No.",PurchaseHeader."No.");

    //             //add posting group



    //             LineNo += 120; 
    //             PurchaseLine."Line No." := LineNo;

    //             PurchaseLine."No.":= CarLine."FA No"; 
    //             // PurchaseLine.Validate("No.",CarLine."FA No");
    //             PurchaseLine."Quantity" := 1; 
    //             PurchaseLine."Unit Cost" := CarLine."Buying Price"; 
    //             PurchaseLine."Description" := CarLine."Chassis Number"; 


    //           if   PurchaseLine.Insert(true) then
    //           begin
    //             PurchaseLine.Validate("No.");
    //             // PurchaseLine.Modify();

    //             PurchaseLine.Modify(true);
    //           end else 
    //             Error('eer')

    //         until CarLine.Next() = 0;

    //     end;
    // end;

   procedure RaisePurchaseInv(var Header: Record "Car Recieving Header"; VendorNo: Code[20])
var
    PurchaseHeader: Record "Purchase Header";
    PurchaseLine: Record "Purchase Line";
    CarLine: Record "Car Line";
    LineNo: Integer;
begin
    // Initialize and Insert Purchase Header
    PurchaseHeader.Init();
    PurchaseHeader."Buy-from Vendor No." := VendorNo; 
    PurchaseHeader.Validate("Buy-from Vendor No.");
    PurchaseHeader."Posting Date" := Header."Date"; 
    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
    PurchaseHeader.VALIDATE("Vendor Invoice No.", Header.No);

    // Insert the Purchase Header and ensure the "No." is correctly assigned
    PurchaseHeader.Insert(true); 
    
    // Manually assign "Document No." after insertion
    if PurchaseHeader."No." = '' then
        Error('Purchase Header No. is missing. Check No. Series.');

    // Now, we need to populate the Purchase Line(s)
    CarLine.Reset();
    CarLine.SetRange("Document No.", Header.No);

    if CarLine.FindSet() then begin
        LineNo := 0; 
        repeat
            // Initialize Purchase Line
            PurchaseLine.Init();
            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;

            // **Directly set the Document No.** from Purchase Header No. to avoid validation errors
            PurchaseLine."Document No." := PurchaseHeader."No."; 

            // Ensure Document No. is correctly assigned
            if PurchaseLine."Document No." = '' then
                Error('Document No. is still empty in Purchase Line.');

            // Set LineNo and other details from CarLine
            LineNo += 10000; // Increment LineNo appropriately
            PurchaseLine."Line No." := LineNo;
            PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
            PurchaseLine."No." := CarLine."FA No"; // Set the Fixed Asset No.
            PurchaseLine."Quantity" := 1;
            PurchaseLine."Unit Cost" := CarLine."Buying Price";
            PurchaseLine."Description" := CarLine."Chassis Number";

            // Insert the Purchase Line after ensuring all required fields are set
            PurchaseLine.Insert(true);
        until CarLine.Next() = 0;
    end;
end;
}