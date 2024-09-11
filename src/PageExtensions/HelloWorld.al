// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.YardManagement;

using Microsoft.Sales.Customer;
using YardManagement.YardManagement;

pageextension 90105 CustomerListExt extends "Customer Card"
{
    layout
    {
        addafter(CustomerStatisticsFactBox)
        {
            part("Kra Cert";"Kra Certificate")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part("Id Copy";"Id Copy")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            
        }
        
    
    }
    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
   
    

}