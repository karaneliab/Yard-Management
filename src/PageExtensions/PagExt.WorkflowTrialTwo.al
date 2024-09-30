pageextension 90110 "Purchases&Payables" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Invoice Nos.")
        {
            field("WorkflowTrial Two Nos."; Rec."Car Receiving Nos.")
            {
                ApplicationArea = All;

            }
        }
    }
}