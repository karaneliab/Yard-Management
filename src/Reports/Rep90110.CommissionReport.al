namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;

report 90110 "Commission Report"
{
    ApplicationArea = All;
    Caption = 'Commission Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/CommissionReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
             column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(department; "Yard Branch")
            {

            }
            // column(Commission; "Comision Paid")
            // {

            // }
            column("OutStanding"; "Outstanding Commission")
            {

            }
            dataitem(CarLine; "Car Line")
            {
                DataItemLink = "Checked In By" = field("No.");
                DataItemLinkReference = Employee;


                RequestFilterFields = "Checked In By";
                column(Commission_Amount; "Commission Amount")
                {

                }
            }
            dataitem("Sales Invoice";"Sales Line")
            {
                // DataItemLink = "No." = field("Yard Branch");
                DataItemLink = "Shortcut Dimension 1 Code" = field("Yard Branch");
                // DataItemLinkReference = Employee;
                column(Commission;Commission)
                {

                }

            }

        }

    }
    labels
    {
        Title = 'commision Report';
    }


    var

        Title: Label 'commission  Report';

}
