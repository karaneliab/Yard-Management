table 90103 "Insuarance Company"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Insuarance Company Card";
    DrillDownPageId = "Insuarance Company Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(2; "Company Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';

        }
        field(3; "Address"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(4; "State"; Text[250])
        {
            Caption = 'State';
            DataClassification = CustomerContent;

        }
        field(5; "Phone Number"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Number';

        }
        field(6; Email; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Email';
        }
        field(7; "Postal Code"; Integer)
        {
            Caption = 'Postal Code';
            DataClassification = CustomerContent;

        }
        field(8; "Website Url"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Website Url';

        }
        field(9; Status; Enum "Insuarance Company Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(10; "Industry Type"; Enum "Industry Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Specifies insurance industry category';
        }
        field(11; "Coverage Types"; Enum "Coverage Types")
        {
            Caption = 'Types of insurance policies provided';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "No.")
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