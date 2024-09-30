namespace YardManagement.YardManagement;

page 90101 "Commission Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Commission Ledger Entries';
    PageType = List;
    SourceTable = "Commission Ledger Entries";
    UsageCategory = History;
    Editable = false;
    SourceTableView = sorting("EntryNo.");
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("EntryNo."; Rec."EntryNo.")
                {
                    ToolTip = 'Specifies the value of the EntryNo. field.', Comment = '%';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field(CarMake; Rec.CarMake)
                {
                    ToolTip = 'Specifies the value of the CarMake field.', Comment = '%';
                }
                field("ChasisNo."; Rec."ChasisNo.")
                {
                    ToolTip = 'Specifies the value of the ChasisNo. field.', Comment = '%';
                }
                field(CommissionAmount; Rec.CommissionAmount)
                {
                    ToolTip = 'Specifies the value of the CommissionAmount field.', Comment = '%';
                }
                 field("CommissionPac"; Rec."CommissionPac")
                {
                    ToolTip = 'Specifies the value of the %Commission field.', Comment = '%';
                }
                field("EmployeeNo."; Rec."EmployeeNo.")
                {
                    ToolTip = 'Specifies the value of the EmployeeNo. field.', Comment = '%';
                }
                
                field(EntryType; Rec.EntryType)
                {
                    ToolTip = 'Specifies the value of the EntryType field.', Comment = '%';
                }
                field("FA No."; Rec."FA No.")
                {
                    ToolTip = 'Specifies the value of the FANo. field.', Comment = '%';
                }
                field(PurchasePrice; Rec.PurchasePrice)
                {
                    ToolTip = 'Specifies the value of the PurchasePrice field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
                }
                field(SalesPrice; Rec.SalesPrice)
                {
                    ToolTip = 'Specifies the value of the SalesPrice field.', Comment = '%';
                }
            }
        }
    }
}
