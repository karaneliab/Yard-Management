namespace YardManagement.YardManagement;

using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Address;

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
            RequestFilterFields = "No.", "Search Name";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
             column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
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
            column(EmployeeAddr_1_; EmployeeAddr[1])
            {
            }
            column(EmployeeAddr_2_; EmployeeAddr[2])
            {
            }
            column(EmployeeAddr_3_; EmployeeAddr[3])
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
            column(Employee_PagerCaption; FieldCaption(Pager))
            {
            }
             column(Employee_Pager; Pager)
            {
            }
            column(age; AgeCalc.CalculateAge(Today, "Birth Date"))
            {

            }
            trigger OnAfterGetRecord()
            begin
                FormatAddr.Employee(EmployeeAddr, Employee);
                if Counter = RecPerPageNum then begin
                    GroupNo := GroupNo + 1;
                    Counter := 0;
                end;
                Counter := Counter + 1;
            end;
        }
    }
    labels
    {
        Title = 'Our Employee Report';
    }


    var
        AgeCalc: codeunit AgeCalculation;
        Title: Label 'Employee Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmployeeAddr: array[8] of Text[100];
        FormatAddr: Codeunit "Format Address";
        Counter: Integer;
        RecPerPageNum: Integer;
        GroupNo: Integer;
}
