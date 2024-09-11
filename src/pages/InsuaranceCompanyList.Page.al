page 90101 "Insuarance Company List"
{
    ApplicationArea = All;
    Caption = 'Insuarance Company List';
    PageType = List;
    SourceTable = "Insuarance Company";
    UsageCategory = Lists;
    CardPageId =  "Insuarance Company Card";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.', Comment = '%';
                }
                field("Industry Type"; Rec."Industry Type")
                {
                    ToolTip = 'Specifies the value of the Specifies insurance industry category field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Coverage Types"; Rec."Coverage Types")
                {
                    ToolTip = 'Specifies the value of the Types of insurance policies provided field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                    Visible = false;
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
                    Visible = false;
                }
            }
        }
    }
}
