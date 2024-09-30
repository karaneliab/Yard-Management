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
                // field("CarNo";Rec.CarNo)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Car Number';
                // }
                field(RegNo; Rec.RegNo)
                {
                    ToolTip = 'Specifies the value of the RegNo field.', Comment = '%';
                }
                field(YardBranch; Rec.YardBranch)
                {
                    ToolTip = 'Specifies the value of the Yard Branch field.', Comment = '%';
                }
                // field("Document No."; Rec."Document No.")
                // {
                //     ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                // }
                field("Checked In By"; Rec."Checked In By")
                {
                    ToolTip = 'Specifies the value of the Checked in by. field.', Comment = '%';
                }

                field("Make";Rec."Car Make")
                {
                    ToolTip = 'Specifies the value of the Car Make field.', Comment = '%';
                }
               
                field("Model";Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Model field.', Comment = '%';
                }
                field("Chassis Number";Rec."Chassis Number")
                {
                    ToolTip = 'Specifies The Car Chasis Number', Comment = '%1';
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the vendor the car was received from', Comment = '%';
                }
                field("Car Insured";Rec."Car Insured")
                {
                    ToolTip = 'Specifies if the car is insured';
                    trigger OnValidate()
                    begin
                        UpdateInsuranceCompanyEditable();
                    end;
                }
                field("Insuarance Company";Rec."Insurance Company")
                {
                    ToolTip = 'Specifies the Insurance company';
                    Editable =  IsInsuranceCompanyEditable;
                }
                
                field("Depreciation Book";Rec."Depreciation Book")
                {
                    ToolTip = 'Specifies the De[reciation book code';
                }
                field("Depreciation Starting Date"; Rec."Depreciation Starting Date")
                
                {
                    ToolTip = 'Specifies the Start of Depreciation Date', Comment = '%';
                
                }  
                field("Depreciation Ending Date";Rec."Depreciation Ending Date")
                {
                    ToolTip = 'Specifies Depreciation Ending Date';
                     ApplicationArea = All;
                }
                field("Country Of First Reg";Rec."Country Of Registration")
                {
                    Tooltip = 'Specifies the Country of first registration';
                   
                }
                field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Bussuness Posting Group";Rec."VAT Bussuness Posting Group")
                {
                    ToolTip = 'Specifies the value of VAT Bussuness Posting Group', Comment = '%';
                }
                field("FA Posting Group";Rec."FA Posting Group")     
                {
                    ToolTip = 'Specifies the value of the FA Posting Group field.', Comment = '%';
                }   
                 field("FA Class Code";Rec."FA Class Code")
                 {
                    ToolTip = 'Specifies the Fa clas code';
                 }
                field("FA Subclass Code";Rec."FA Subclass Code")
                {
                    ToolTip = 'Fa subclass Code';
                }
                //  field("Commission Amount"; Rec."Commission Amount")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Displays the commission amount for the car make.';
                // }
            }
        }
    }

  var
        IsInsuranceCompanyEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateInsuranceCompanyEditable();
    end;

    procedure UpdateInsuranceCompanyEditable()
    begin
        IsInsuranceCompanyEditable := Rec."Car Insured";
    end;
   
            // action("Recalculate Commission")
            // {
            //     Caption = 'Recalculate Commission';
            //     Image = Recalculate;
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin
            //         Rec. CommisionCalculate();
            //         Rec.Modify();
            //     end;
            // }
        }
    

    // trigger OnOpenPage()
    // begin
    //     // Calculate the commission when the page is opened
    //     Rec.CommisionCalculate();
    // end;

