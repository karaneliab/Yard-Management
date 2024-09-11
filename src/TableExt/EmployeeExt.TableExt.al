tableextension 90101 "Employee Ext" extends Employee
{
    fields
    {
        // Add changes to table fields here
        field(56789;"KRA PIN";Code[9])
        {
            DataClassification = CustomerContent;
            Caption = 'Kra Pin';
        }
        field(67843;"NHIF NO";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'NHIF NO';
        }
        field(67543;"NSSF NO";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'NSSF NO';
        }
        field(56478;"Personal Email";Text[50])
        {
            Caption  = 'Personal Mail';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                pattern := '^[a-z0-9+_.-]+@[a-z0-9.-]+$';
                if regex.IsMatch(Rec."Personal Email", pattern, 0) then
                    Message('Matched')
                else
                    Error('Invalid Email Format');
            end;
        }
        field(67845;"ID Number"; Text[20])
        {
            Caption = 'ID Number';
            DataClassification = CustomerContent;
           

        }
        field(67990;"Basic Pay";Decimal)
        {  
            Caption = 'Basic Pay';
            DataClassification = CustomerContent;
        }
        field(77894;"Yard Branch";Text[250])
        {
            Caption = 'Yard Branch';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(67875;"Passport"; Code[20])
        {
            Caption = 'Paasport ';
            DataClassification = CustomerContent;
          
           
        }
        field(83674;"Comision Paid";Decimal)
        {
            Caption = 'Commission Paid';
            DataClassification = CustomerContent;
           
        }
        field(87463;"Outstanding Commission";Decimal)
        {
            Caption = 'Outstanding Commission';
            DataClassification = CustomerContent;
        }
   
    }
    var
        regex: Codeunit Regex;
        pattern: Text;

    var
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';
        AgeCalculations: Codeunit AgeCalculation;

    
  
}