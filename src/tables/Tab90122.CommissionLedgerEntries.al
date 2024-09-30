table 90122 "Commission Ledger Entries"
{
    Caption = 'Commission Ledger Entries';
    DataClassification = ToBeClassified;
    DrillDownPageID ="Commission Ledger Entries";
    LookupPageID = "Commission Ledger Entries";
    
    fields
    {
        field(1; "EntryNo."; Integer)
        {
            Caption = 'EntryNo.';
            AutoIncrement = true;
        }
        field(2; EntryType; Option)
        {
            Caption = 'EntryType';
            OptionCaption = ',Payment,Booking';
            OptionMembers = " ",Payment,"Booking";
        }
        field(3; "EmployeeNo."; Code[20])
        {
            Caption = 'EmployeeNo.';
            TableRelation = Employee;
        }
        field(4; CarMake; Text[250])
        {
            Caption = 'CarMake';
            TableRelation = "CAR Make";
        }
        field(5; "ChasisNo."; Code[20])
        {
            Caption = 'ChasisNo.';
            TableRelation = "Car Line";
        }
        field(6; SalesPrice; Decimal)
        {
            Caption = 'SalesPrice';
            // FieldClass = FlowField;
            // CalcFormula = lookup("Sales Invoice Line"."Unit Price" WHERE("No." = field("FA No.")));
        }
        field(7; PurchasePrice; Decimal)
        {
            Caption = 'PurchasePrice';
            
            // CalcFormula = lookup("Purch. Inv. Line"."Direct Unit Cost" WHERE("No." = field("FA No.")));
                                                                  

        }
        field(8; "FA No."; Code[20])
        {
            Caption = 'FANo.';
        }
        field(9; "CommissionPac"; Decimal)
        {
            Caption = 'Commission Pac';
        }
        field(10; CommissionAmount; Decimal)
        {
            Caption = 'CommissionAmount';
        }
        field(11; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(12; Branch; Text[250])
        {
            Caption = 'Branch';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false)); 
        }
    }
    keys
    {
        key(PK; "EntryNo.")
        {
            Clustered = true;
        }
        key(key2; "EmployeeNo.")
        {

        }
    }
    
    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("EntryNo.")))
    end;
}
