namespace YardManagement.YardManagement;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Sales.Customer;
using Microsoft.FixedAssets.Ledger;

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
            RequestFilterFields = "Responsible Employee",Acquired,"Global Dimension 1 Code";
            column(RegNo; RegNo)
            {
            }
            
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
             column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(YearofManufacture; "Year of Manufacture")
            {
            }
            column(InsuaranceCompany; "Insurance Company")
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
            column(Acquisition_cost;"AcquisitionCost")
            {

            }
            
            dataitem("FA Ledger Entry";"FA Ledger Entry")
            {
                DataItemLink = "FA No." = Field("FA No.");
                DataItemLinkReference = "FA Ledger Entry";
                column(FA_Posting_Category;"FA Posting Category")
                {
                    
                }
                column(Part_of_Book_Value;"Part of Book Value")
                {

                }
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

