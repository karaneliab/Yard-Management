
table 90100 "CAR Make"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Car Make Card";
    LookupPageId = "Car Make Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Make ID NO';
            DataClassification = CustomerContent;

        }
        field(2; " Make Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Make Name';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
        // Add changes to field groups here
    }

    // var
    //     myInt: Integer;

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
