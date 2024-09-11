namespace YardManagement.YardManagement;

using Microsoft.FixedAssets.FixedAsset;

report 90120 "Stock Report"
{
    ApplicationArea = All;
    Caption = 'Stock Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Excel;
    ExcelLayout  = './src/Cars/StockReport.xlsx';
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
            column(FALocationCode; "FA Location Code")
            {
            }
        }
        dataitem(CarRecievingHeader;"Car Recieving Header")
        {
            column(Date_Received;Date)
            {

            }
            column(Buying_Price;"Buying Price")
            {

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
}
