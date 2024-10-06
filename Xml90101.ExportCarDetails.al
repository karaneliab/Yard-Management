namespace YardManagement.YardManagement;

xmlport 90127 "Export Car Details"
{
    Caption = 'Export Car Details';
    Direction = Export;
    TextEncoding = UTF8;
    Format=VariableText;
    UseRequestPage = false;
    TableSeparator = '';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(CarLine; "Car Line")
            {
                XmlName = 'CarLine';
                RequestFilterFields ="Chassis Number";


                fieldelement(CarInsured; CarLine."Car Insured")
                {
                }
                fieldelement(CarMake; CarLine."Car Make")
                {
                }
                fieldelement(CarModel; CarLine."Car Model")
                {
                }
                fieldelement(Received_From;CarLine."Received From")
                {

                }
                fieldelement(Chassis_No;CarLine."Chassis Number")
                {

                }
                fieldelement(YardBranch;CarLine.YardBranch)
                {

                }
                fieldelement(Year_of_Make;CarLine."Year of Make")
                {

                }
                fieldelement(RegNo;CarLine.RegNo)
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
}
