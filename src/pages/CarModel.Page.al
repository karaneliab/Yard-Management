page 90106 "Car Model"
{
    ApplicationArea = All;
    Caption = 'Car Model';
    PageType = List;
    SourceTable = "CAR Model";
    UsageCategory = Lists;
    // CardPageId = "Car Model card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the Model ID NO field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the Car Make field.', Comment = '%';
                    ApplicationArea = All;
                    
                }

                field(" Model Name"; Rec." Model Name")
                {
                    ToolTip = 'Specifies the value of the Model Name field.', Comment = '%';
                    ApplicationArea = All;
                }

            }
        }
    }
}
