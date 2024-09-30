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