namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;

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
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(department; "Yard Branch")
            {

            }
            column(Commission; "Comision Paid")
            {

            }
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

        }

    }
    labels
    {
        Title = 'commision Report';
    }


    var

        Title: Label 'commission  Report';

}
