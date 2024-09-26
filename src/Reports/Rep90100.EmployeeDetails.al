namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;

report 90100 "Employee Details"
{
    ApplicationArea = All;
    Caption = 'Employee Details';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/EmployeeDetails.rdl';
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
            column(Date_of_Birth; "Birth Date")
            {
            }
            column(ID_Number; "ID Number")
            {

            }
            column(Status; Status)
            {

            }
            column(LastDateModified; "Last Date Modified")
            {
            }
            column(Yard_Branch; "Yard Branch")
            {

            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(PersonalEmail; "Personal Email")
            {
            }
            column(BasicPay; "Basic Pay")
            {
            }
            column(Image; Image)
            {

            }
            column(age; AgeCalc.CalculateAge(Today, "Birth Date"))
            {

            }
        }
    }
    labels
    {
        Title = 'Our Employee Report';
    }


    var
        AgeCalc: codeunit AgeCalculation;
        Title: Label 'Employee Report';
}
