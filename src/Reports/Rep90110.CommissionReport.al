namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;

report 90110 "Commission Report"
{
    ApplicationArea = All;
    Caption = 'Commission Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Excel;
    ExcelLayout  = './src/Cars/CommissionReport.xlsx';
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No; "No.")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Commission; "Comision Paid")
            {

            }
            column("OutStanding"; "Outstanding Commission")
            {

            }

        }
        dataitem(CarLine; "Car Line")
        {
            RequestFilterFields ="Checked In By";
            column(Commission_Amount;"Commission Amount")
            {

            }
        }
    }

}
