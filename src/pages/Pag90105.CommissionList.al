namespace YardManagement.YardManagement;

page 90105 "Commission List"
{
    ApplicationArea = All;
    Caption = 'Commission List';
    PageType = List;
    SourceTable = "Commission Rate";
    UsageCategory = Lists;
    CardPageId = "Commission Setup Card";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Car Make No"; Rec."Car Make No")
                {
                    ToolTip = 'Specifies the value of the Car Make No field.', Comment = '%';
                }
                field("Commission Rate"; Rec."Commission Rate")
                {
                    ToolTip = 'Specifies the value of the Commission percentage field.', Comment = '%';
                }
            }
        }
    }
}
