namespace YardManagement.YardManagement;

using System.Security.User;

pageextension 90103 UserSetup extends "User Setup"
{
     layout
     {
        addafter("User ID")
        {
            field("User Name"; Rec ."Employe Number")
            {
                ApplicationArea = All;

            }
        }
     }
}
