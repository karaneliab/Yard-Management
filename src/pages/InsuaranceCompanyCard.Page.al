page 90110 "Insuarance Company Card"
{
    ApplicationArea = All;
    Caption = 'Insuarance Company Card';
    PageType = Card;
    SourceTable = "Insuarance Company";
    SourceTableView = SORTING("No.");
    UsageCategory = Documents;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Coverage Types"; Rec."Coverage Types")
                {
                    ToolTip = 'Specifies the value of the Types of insurance policies provided field.', Comment = '%';
                }
                field("Industry Type"; Rec."Industry Type")
                {
                    ToolTip = 'Specifies the value of the Specifies insurance industry category field.', Comment = '%';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ToolTip = 'Specifies the value of the Postal Code field.', Comment = '%';
                    Visible = false;
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = '%';
                    Visible = false;
                }
                field("Website Url"; Rec."Website Url")
                {
                    ToolTip = 'Specifies the value of the Website Url field.', Comment = '%';
                    visible = false;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
            }
        }
    }
}
