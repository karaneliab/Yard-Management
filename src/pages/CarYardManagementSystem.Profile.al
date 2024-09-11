


page 90115 "Car Yard Management "
{
    PageType = RoleCenter;
    Caption = 'Car Yard Management Role Center';
    ApplicationArea = Basic, Suite;


    layout
    {
        area(RoleCenter)
        {
            part(Eliab1; "Approvals Activities")
            {
                ApplicationArea = All;
            }

            part("Eli&ab2"; "Posted Sales Invoice Subform")
            {
                ApplicationArea = All;

            }
            part("Car subform"; "Car Subform")
            {
                ApplicationArea = All;
            }


        }
    }

    actions
    {
        area(Creation)
        {
            separator(Action87)
            {
            }
            action("S&ales Order")
            {
                RunObject = Page "Sales Order";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new sales order ', Comment = ' %1';
                RunPageMode = Create;

            }
            action("P&urchase Order")
            {
                RunObject = Page "Purchase Order";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new purchase order ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("car receiving card")
            {
                RunObject = Page "Car Receiving Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new receiving card ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("E&mployees")
            {
                RunObject = Page "Employee Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new employee ', Comment = ' %1';
                RunPageMode = Create;

            }
            separator(Action97)
            {
            }
            action("Cust&omers")
            {
                RunObject = Page "Customer Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new customer ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("V&endors")
            {
                RunObject = Page "Vendor Card";
                ApplicationArea = All;
                Tooltip = 'Specifies new vendor', Comment = '%1';
                RunPageMode = Create;
            }
            action("Purchase&Invoices")
            {
                RunObject = Page "Purchase Invoice";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies new purchase invoice', Comment = '%1';
                RunPageMode = Create;
            }
            action("Fixed Assets")
            {
                ApplicationArea = All;
                RunObject = Page "Fixed Asset List";
                RunPageMode = View;
                ToolTip = 'Specifies new fixed assets';
            }
        }
        area(Sections)
        {
            group("Car Yard")
            {
                separator(Tasks)
                {
                    Caption = 'Tasks';
                    IsHeader = true;
                }
                action("Employees")
                {
                    RunObject = Page "Employee List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employees';
                }

                action("Fixes Assets")
                {
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixes Assets';

                }

            }
            group("S&etup")
            {
                group("Setup")
                {
                    action("Car Model")
                    {
                        RunObject = Page "Car Model";
                        ApplicationArea = All;
                        Caption = 'Car Model';
                        Tooltip = 'Setup Car Model';

                    }
                    action("Car Make")
                    {
                        RunObject = Page "Car Make setup";
                        Caption = 'Car Make';
                        ApplicationArea = All;
                    }
                    separator("Ta&ks")
                    {
                        Caption = 'Tasks';
                        IsHeader = true;
                    }
                    action("Insuarance Company")
                    {
                        RunObject = Page "Insuarance Company List";
                        Caption = 'Insuarance company list';
                        ToolTip = 'Specifies the car Insurance company';
                    }
                    action("Car Receiving")
                    {
                        RunObject = Page "Car Receiving Card";
                        Caption = 'Car Receiving Card';
                    }
                    separator(Action67)
                    {
                    }
                    action("General &Ledger Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General &Ledger Setup';
                        Image = Setup;
                        RunObject = Page "General Ledger Setup";
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("&Sales && Receivables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Sales && Receivables Setup';
                        Image = Setup;
                        RunObject = Page "Sales & Receivables Setup";
                        ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    }
                    action("&Purchases && Payables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Purchases && Payables Setup';
                        Image = Setup;
                        RunObject = Page "Purchases & Payables Setup";
                        ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    }
                    action("&Fixed Asset Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = '&Fixed Asset Setup';
                        Image = Setup;
                        RunObject = Page "Fixed Asset Setup";
                        ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    }
                    action("&FA Locations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = '&Fixed Asset Setup';
                        Image = Setup;
                        RunObject = Page "FA Locations";
                        ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    }
                }
            }
            group("Sales")
            {
                action("Customers")
                {
                    RunObject = Page "Customer List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';

                    ToolTip = 'View a list of all customers and their contact information, including addresses, phone';
                }
                action("Sales Invoce")
                {
                    RunObject = Page "Sales Invoice List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice';
                    Image = SalesInvoice;
                    ToolTip = 'View a list of all sales invoices and their status, including the date posted';

                }
                action("Sales Order")
                {
                    RunObject = Page "Sales Order";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    ToolTip = 'Defines a list of all sales orders made';


                }
                action("Posted Sales")
                {
                    RunObject = Page "Posted Sales Invoice Lines";

                }
                action("Posted Sales invoices")
                {
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                }

            }
            group(Purchases)
            {
                action(Vendors)
                {
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                }
                action("Purchase Order")
                {
                    RunObject = Page "Purchase Order";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order';
                    ToolTip = 'Defines a list of all purchase orders made';



                }
                action("Posted Purchases")
                {
                    RunObject = Page "Posted Purchase Invoice Lines";
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoice Lines';

                }
                action("Posted Purchase Invoices")
                {
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                }

            }
        }
        area(Embedding)
        {
            action("FA Locations")
            {
                RunObject = Page "FA Locations";
            }
        }
    }
}
profile "Car Yard Management System"
{
    Caption = 'Car Yard Management';
    RoleCenter = "Car Yard Management ";


}