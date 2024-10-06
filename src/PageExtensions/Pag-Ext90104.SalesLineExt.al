namespace YardManagement.YardManagement;

using Microsoft.Sales.Document;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Sales.History;

pageextension 90104 SalesLineExt extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Make; Rec.Make)
            {
                ToolTip = 'Specifies the Make of the car';
            }
            field("CommissionPac"; Rec."CommissionPac")
            {
                ToolTip = 'Specifies the Commission of the car';
            }
            field("AcquisitionCost"; Rec.AcquisitionCost)
            {
                ToolTip = 'Specifies the Acquisition Cost of the car';
                trigger OnDrillDown()
                var
                    FADepreciationBook: Record "FA Depreciation Book";
                begin
                    FADepreciationBook.DrillDownOnBookValue();
                end;

            }
        }
        addafter("Unit Price")
        {
            field(Commission;Rec.Commission)
            {
                ToolTip = 'Specifies the total Commission of the car';
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
         action("Recalculate Commission")
           {
            //    Caption = 'Recalculate Commission';
            //    Image = Recalculate;
            //    ApplicationArea = All;

            //    trigger OnAction()
            //    begin
            //        Rec. CommisionCalculate();
            //        Rec.Modify();
            //    end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        FixedAsset: Record Microsoft.FixedAssets.FixedAsset."Fixed Asset";
        CommissionRate:Record "Commission Rate";
    
    begin

        if Rec."No." <> '' then begin

            if FixedAsset.Get(Rec."No.") then begin
                Rec.Make := FixedAsset."Car Make";
            

                FixedAsset.CalcFields(AcquisitionCost);


                Rec.AcquisitionCost := FixedAsset.AcquisitionCost;
            end else begin

                Rec.Make := '';
                Rec.AcquisitionCost := 0;
            end;
        end;
    end;
   
  
   
    
}
pageextension 90107 SalesLineList extends "Sales Lines"
{
    layout
    {
        addafter(Description)
        {
             field(Make; Rec.Make)
            {
                ToolTip = 'Specifies the Make of the car';
            }
            field("CommissionPac"; Rec."CommissionPac")
            {
                ToolTip = 'Specifies the Commission of the car';
            }
             field(Commission;Rec.Commission)
            {
                ToolTip = 'Specifies the total Commission of the car';
            }
        }
    }
}
pageextension 90108 PostSalesLine extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter(Description)
        {
             field(Make; Rec.Make)
            {
                ToolTip = 'Specifies the Make of the car';
            }
            field("CommissionPac"; Rec."CommissionPac")
            {
                ToolTip = 'Specifies the Commission of the car';
            }
             field("Acquisition cost";Rec."Acquisition cost")
            {
                ToolTip = 'Specifies the total Commission of the car';
            }
        }
    }
}
