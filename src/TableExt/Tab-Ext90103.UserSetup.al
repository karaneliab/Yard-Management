namespace YardManagement.YardManagement;

using System.Security.User;
using Microsoft.HumanResources.Employee;

tableextension 90103 UserSetup extends "User Setup"
{
    fields
    {
        field(90100; "Employe Number"; Code[20])
        {
            Caption = 'Employe Number';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
}
