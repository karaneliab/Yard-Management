page 90109 "Car Model card"
{
    ApplicationArea = All;
    Caption = 'Car Model card';
    PageType = Card;
    SourceTable = "CAR Model";
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the Model ID NO field.', Comment = '%';
                }

                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the Car Make field.', Comment = '%';
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
