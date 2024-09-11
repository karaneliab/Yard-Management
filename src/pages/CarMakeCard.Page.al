page 90108 "Car Make Card"
{
    ApplicationArea = All;
    Caption = 'Car Make Card';
    PageType = Card;
    SourceTable = "CAR Make";
    UsageCategory  = Documents;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Make ID NO field.', Comment = '%';
                    ApplicationArea = All;

                }
                field("Make Name"; Rec." Make Name")
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Name of Make';
                }
              
            }
        }
    }
     actions
    {
        area(Processing)
        {
            
            action("Car Model List")
            {
                ApplicationArea = All;
                Caption = 'Car Model';
                ToolTip = 'Open Car Model List';
                Image = FixedAssets;
                RunObject = Page "Car Model";
                // RunPageLink = "No." = field("Customer No.");
            }
        }
    }
}
