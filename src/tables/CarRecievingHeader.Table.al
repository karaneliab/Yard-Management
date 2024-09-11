table 90110 "Car Recieving Header"
{
    DataClassification = CustomerContent;
     DrillDownPageId = "recieving List";
    LookupPageId = "recieving List";


    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
            
        }
     
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

        }
        field(10; "Buying Price"; Decimal)
        {
            Caption = 'Buying Price';
            // DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line"."Unit Price" where("No." = field("Customer No.")));

        }
         field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                TestStatus();
                CalcFields("Customer Name");
            end;
        }

        field(5; "Status"; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestOnRelease();
            end;
        }
        field(6; "Last Released Date"; DateTime)
        {
            Caption = 'Last Released Date';
            DataClassification = CustomerContent;
            Editable = false;

        }
         field(7; "Customer Name"; Text[100])
        {
            Caption = ' Customer name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));

    }

    }
       local procedure TestStatus()
    begin
        if Status <> Status::"Approved" then
        exit;
            // Error(StatusCannotBeReleasedErr, Status);
        // TestField("Customer No.");
        "Last Released Date" := CurrentDateTime;
    end;

     local procedure TestOnRelease()
    begin
        if Status <> Status::Approved then
            exit;
        // TestField("Customer No.");
        "Last Released Date" := CurrentDateTime;
    end;

    
    var
        // myInt: Integer;
    
    trigger OnInsert()
    begin
        
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
    
}