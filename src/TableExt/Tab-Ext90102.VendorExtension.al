namespace YardManagement.YardManagement;

using Microsoft.Purchases.Vendor;

tableextension 90102 "VendorExtension" extends Vendor
{
    fields
    {
        field(90100; "Vendor Type"; Enum "VendorType")
        {
            Caption = 'Vendor Type';
            DataClassification = ToBeClassified;
        }
        field(90101; "Company Name"; Text[40])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
        }
        
        field(90103; "Company's Mail"; Text[40])
        {
            Caption = 'Company''s Mail';
            DataClassification = ToBeClassified;
        }
        field(90104; Status; Enum "Insuarance Company Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            trigger OnValidate()
            begin
                "Vendor Validation"()
            end;
        }
    }
   procedure "Vendor Validation"()
   begin
    if "Vendor Type" = "Vendor Type"::Insurer then begin
        if "Company Name" = '' then
        Error('Company Name is required for Insurer');
        if "Company's Mail" = '' then
        Error('Company''s Mail is required for Insurer');
        
   end 
//    else if "Vendor Type" = "Vendor Type"::Supplier then begin
//         "Company Name".Editable := false;
//         "Company's Mail".Editable := false;
//     end;
    end;
        
        

   
}
