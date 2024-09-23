namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;

report 90100 "Employee Details"
{
    ApplicationArea = All;
    Caption = 'Employee Details';
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = Excel;
    // ExcelLayout  = './src/Cars/EmployeeDetails.xlsx';
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
            column(BirthDate; "Birth Date")
            {
            }
            column(Status;Status)
            {

            }
            column(LastDateModified; "Last Date Modified")
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
            column(Image;Image)
            {
                
            }
            column(age; AgeCalc.CalculateAge(Today, "Birth Date"))
            {

            }
        }
    }
    

    var
        AgeCalc: codeunit AgeCalculation;
}
