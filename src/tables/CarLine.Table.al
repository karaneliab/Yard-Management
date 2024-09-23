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
    
        field(2; RegNo; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RegNo';
        }
        field(3; "Checked In By"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Checked in by.';
            TableRelation = Employee where ("Yard Branch"=field(YardBranch));
            

        }
        field(4; YardBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Yard Branch';
            TableRelation =  "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
            CaptionClass = '1,1,1';

        }
        field(5;"Year of Make";Date)
        {
            Caption = 'Year of Make';
            DataClassification = CustomerContent;


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
            TableRelation = "CAR Make";
      
        }
        field(8; "Car Model"; Text[40])
        {
            Caption = 'Car Model';
            DataClassification = CustomerContent;
            TableRelation = "CAR Model"  where(Make=field("Car Make"));;
        }
        field(9; "Chassis Number"; Code[40])
        {
            Caption = 'Chasis Number';
            DataClassification = CustomerContent;
            
        }
        field(10;"Insurance Company";Text[20])
        {
            Caption = 'Insurance Company';
            DataClassification = CustomerContent;
            TableRelation = "Insuarance Company";
        }
        field(11; "Country Of Registration"; Text[250])
        {
            Caption = 'Country Of Registration';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }

        field(12; "FA Posting Group"; Code[20])
        {
            Caption = 'FA posting group';
            DataClassification = CustomerContent;
            TableRelation = "FA Posting Group";
        }
         field(13; "FA Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            TableRelation = "FA Class";
        }
         field(15; "FA Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            TableRelation = "FA Subclass" where("FA Class Code"=field("FA Class Code"));;
        }
      
        // FIELD(14;)
        field(16; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(17; "VAT Bussuness Posting Group"; Code[20])
        {
            Caption = ' VAT Business Posting Group';
            TableRelation = "VAT Business Posting Group";

        }
        field(18; "Depreciation Book"; Code[20])
        {
            Caption = 'Depreciation Book';
            // DataClassification = Normal;
            TableRelation = "Depreciation Book";
        }
        field(19;"FA No";code[20])
        {
            Caption = 'fixed asset no';
            TableRelation = "Depreciation Book";
        }
        field(20; "Tax Code"; Code[20])
        {
            Caption = 'Tax Code';
            TableRelation = "Tax Group";
        }
        field(21;"Depreciation Starting Date";Date)
        {
            Caption = 'Depreciation Starting Date';
            
        }
        field(22;"Depreciation Ending Date";Date)
        {
            
            Caption = 'Depreciation Ending Date';
        }
        field(23;"No of Depreciation Years"; Decimal)
        {
            Caption = 'No of depreciation years';
        }
        field(25; "Car Insured"; Boolean)
        {
            Caption = 'Car Insured';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Car Insured" then begin
                    "Insurance Company" := '';
                    "Year of Manufacture" := 0D;

                end;

            end;
        }
      
         field(80505; "Year of Manufacture"; Date)
        {
            Caption = 'Year of Manufacture';
            DataClassification = ToBeClassified;
        }
         field(30; "Commission Amount"; Decimal)
        {
            Caption = 'Commission Amount';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(ki; RegNo, "Document No.",YardBranch)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TestStatus();
         CommisionCalculate()
    end;

    trigger OnModify()
    begin
        TestStatus();
         CommisionCalculate()

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


    procedure CommisionCalculate()
    var
        CarReceivingHeader: Record "Car Recieving Header";
        CommissionRate: Decimal;
        CarMakeCommission: Record "Commission Rate";
        BuyingPrice: Decimal;
    begin
        if CarReceivingHeader.Get(Rec."Document No.") then begin
            BuyingPrice := CarReceivingHeader."Buying Price";

            
            if CarMakeCommission.Get(Rec."Car Make") then begin
                CommissionRate := CarMakeCommission."Commission Rate";

                
                "Commission Amount" := CalculateCommissionAmount(CommissionRate, BuyingPrice);
            end;
        end;
    end;

    procedure CalculateCommissionAmount(CommissionRate: Decimal; BuyingPrice: Decimal): Decimal
    begin
        exit((BuyingPrice * CommissionRate) / 100); 
    end;
    

    var
        
        ProdOrderLine: Record "Prod. Order Line";
        Text022: Label 'Do you want to change %1?';
        GLSetup: Record "General Ledger Setup";

        Text023: Label 'You cannot delete %1 %2 because there is at least one %3 that includes this item.';
        Text024: Label 'If you change %1 it may affect existing production orders.\';
        GenProdPostingGrp: Record "Gen. Product Posting Group";
}