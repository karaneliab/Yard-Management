pageextension 90101 "Fixed Assets" extends "Fixed Asset Card"
{
    layout
    {


        addafter(General)

        {
            group("Car Details")
            {
                field("Car Make"; Rec."Car Make")
                {
                    Tooltip = 'Specifies the Car Make .', Comment = '%';
                    ApplicationArea = All;
                }
                field("Model"; Rec."Model")
                {
                    ToolTip = 'Specifies the Car Model.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Insuarance Company"; Rec."Insuarance Company")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the Insuarance Company.', Comment = '%';

                    // Visible =Rec. "Car Insured"; // Show the field only when "Car Insured" is true

                }
                field("RegNo"; Rec.RegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RegNo.', Comment = '%';
                }
                field("ChassisNo"; Rec.ChassisNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies chassis number', Comment = '%';
                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Year of Manufacture.', Comment = '%';
                }
                field("Car Insured"; Rec."Car Insured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the insuarance  company', Comment = '%';

                    trigger OnValidate()
                    begin
                        // If Car Insured is changed, update the page to reflect visibility changes
                        CurrPage.Update();
                    end;

                }
                field("Country Of First Registration"; Rec."Country Of First Registration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Country Of First Registration.', Comment = '%';
                }


            }

        }

        addafter(FixedAssetPicture)
        {
            part("specific car"; "Specific car details")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part("Right"; "Right Side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part("Left"; "Left side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part(Back; "Back Side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }


        }

    }
    

}
