page 90102 "Car Receiving Card"
{
    ApplicationArea = All;
    Caption = 'Car Receiving Card';
    PageType = Card;
    SourceTable = "Car Recieving Header";
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the  Date field.', Comment = '%';
                }
                field("Last Released Date"; Rec."Last Released Date")
                {
                    ToolTip = 'Specifies the value of the Last Released Date field.', Comment = '%';
                }

                field("Customer no"; Rec."Customer No.")
                {
                    Tooltip = 'specifies customer no';
                }
                field("customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';

                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part(Lines; "Car Subform")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No");

            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Fixed Asset"),
                              "No." = field("No");
            }
            part(Statistics; "Customer Statis&tics")
            {
                SubPageLink = "No" = field("No");
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            action("Customer card")
            {
                ApplicationArea = All;
                Caption = 'CUSTOMER';
                ToolTip = 'Open Customer card';
                Image = Customer;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = field("Customer No.");
            }
            action("Posted Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Posted Sales Invoice';
                ToolTip = 'Open Posted Sales Invoice';
                Image = "Sales";
                RunObject = Page "Posted Sales Invoice";
                RunPageLink = "Sell-to Customer No." = field("Customer No.");

            }
        }
        area(Processing)
        {
            action("Post")
            {
                ApplicationArea = All;
                Caption = 'Post';
                ToolTip = 'Post the document';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = field("Customer No.");

            }
        }
    }
}