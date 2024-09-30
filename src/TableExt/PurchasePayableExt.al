tableextension 90110 "Purchase&PayablesExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(521923; "Car Receiving Nos."; Code[10])
        {
            Caption = 'Car Receiving Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}