page 90103 "Car Subform"
{
    ApplicationArea = All;
    Caption = 'Car Subform';
    PageType = ListPart;
    SourceTable = "Car Line";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(RegNo; Rec.RegNo)
                {
                    ToolTip = 'Specifies the value of the RegNo field.', Comment = '%';
                }
                field(YardBranch; Rec.YardBranch)
                {
                    ToolTip = 'Specifies the value of the Yard Branch field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Checked In By"; Rec."Checked In By")
                {
                    ToolTip = 'Specifies the value of the Checked in by. field.', Comment = '%';
                }
            }
        }
    }
}
