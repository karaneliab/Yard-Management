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
        field(2; RegNo; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = ' RegNo';
            TableRelation = "Fixed Asset".RegNo;

        }
        field(3; "Checked In By"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Checked in by.';
            TableRelation = Employee;
            trigger OnLookup()
            begin
                EmployeeStatus();
            end;
            
        }
        field(4; YardBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Yard Branch';
            TableRelation = Dimension;
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
            if EmployeeStatus.Status =EmployeeStatus.Status::"Active" then
                Error(EmployeeStatusErr,EmployeeStatus.Status);
    end;
}