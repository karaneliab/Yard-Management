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
            dataitem(CarRecievingHeader; "Car Recieving Header")
            {
                DataItemLink = "FA No." = field("No.");
                DataItemLinkReference= FixedAsset;
                column(Date_Received; Date)
                {

                }
                column(Buying_Price; "Buying Price")
                {

                }
            }
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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
