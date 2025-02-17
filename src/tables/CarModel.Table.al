table 90104 "CAR Model"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Car Model card";
    LookupPageId = "Car Model Card";


    fields
    {
        field(1; "ID"; Code[20])
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;

        }
        field(3; "Make"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            TableRelation = "CAR Make";
        }
        field(2; " Model Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Model Name';

        }

    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
    }
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