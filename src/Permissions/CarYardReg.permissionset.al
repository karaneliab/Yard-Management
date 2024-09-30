permissionset 90102 "CAR Yard Reg."
{
    Assignable = true;
    Caption ='Car Yard';
    Permissions = 
        tabledata "CAR BranchTable" = RMID,
        tabledata "CAR Make" = RMID,
        // tabledata "Insuarance Company" = RMID,
        tabledata "CAR Model" = RMID,
        tabledata  "Car Line" = RMID,
        tabledata "Car Recieving Header" = RMID;
}