namespace YardManagement.YardManagement;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Sales.Customer;

report 90120 "Stock Report"
{
    ApplicationArea = All;
    Caption = 'Stock Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/StockReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "Responsible Employee";
            column(RegNo; RegNo)
            {
            }
            column(YearofManufacture; "Year of Manufacture")
            {
            }
            column(InsuaranceCompany; "Insuarance Company")
            {
            }
            column(CarInsured; "Car Insured")
            {
            }
            column(ChassisNo; ChassisNo)
            {
            }
            column("Branch"; "FA Location Code")
            {

            }

        }

    }

    labels
    {
        Title = 'Yard Management Stock Report';
    }
    var
        Title: Label 'Stock Report';
}

