namespace Microsoft.Sales.Customer;
using System.Automation;
using Microsoft.Purchases.Document;
using Microsoft.FixedAssets.FixedAsset;
using YardManagement.YardManagement;
page 90102 "Car Receiving Card"
{
    ApplicationArea = All;
    Caption = 'Car Receiving Card';
    PageType = Card;
    SourceTable = "Car Recieving Header";
    // UsageCategory = Documents;
    PromotedActionCategories = 'Approval';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the  Date field.', Comment = '%';
                }

                field("Last Released Date"; Rec."Last Released Date")
                {
                    ToolTip = 'Specifies the value of the Last Released Date field.', Comment = '%';
                }
                // ?field("Buying Price"; Rec."Buying Price")
                // {
                //     ToolTip = 'Specifies the value of the Buying Price field.', Comment = '%';

                // }


                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Buying Price"; Rec."Buying Price")
                {
                    ToolTip = 'Specifies the value of the Buying Price field.', Comment = '%';
                    Editable = false;
                }
            }
            part(Lines; "Car Subform")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No");
                UpdatePropagation = Both;

            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }

            part(Statistics; "Customer Statis&tics")
            {
                SubPageLink = "No" = field("No");
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }

        }
    }
    actions
    {

        area(processing)
        {

            // action("Po&st")
            // {
            //     Caption = 'P&ost';
            //     Image = PostOrder;
            //     trigger OnAction()
            //     var
            //         CustomWorkflowMgmt: Codeunit "Custom Workflow Mgmt";
            //         RecRef: RecordRef;
            //         PurchaseHeader: Record "Purchase Header";
            //     begin
            //         // Check if the status is 'Approved'/
            //         if Rec.Status <> Rec.Status::Approved then begin

            //             if Confirm('The document is not approved. Do you want to send it for approval?', true, false) then begin
            //                 RecRef.GetTable(Rec);
            //                 if CustomWorkflowMgmt.CheckApprovalsWorkflowEnabled(RecRef) then
            //                     CustomWorkflowMgmt.OnSendWorkflowForApproval(RecRef);
            //                 Message('The document has been sent for approval.');
            //             end else
            //                 Message('Posting cancelled.');
            //             // exit;
            //         end;

            //         // If the status is 'Approved', proceed with posting
            //         if not Confirm('Do you want to post the car receipt?', true, false) then
            //             Message('Posting cancelled.')
            //         else begin
            //             Rec.PostCarDetails(Rec);
            //             Message('Car details posted successfully.');
            //             // Page.Run(Page::"Purchase Invoice",PurchaseHeader);
            //             Page.Run(Page::"Fixed Asset Card");
            //         end;
            //     end;
            // }
            action("Po&st")
            {
                Caption = 'P&ost';
                Image = PostOrder;
                trigger OnAction()
                var
                    CarLine: Record "Car Line";
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseInvoiceNo: Code[20];
                    CustomWorkflowMgmt: Codeunit "Custom Workflow Mgmt";
                    RecRef: RecordRef;
                    VendorNo: Code[20];
                begin
                    // if Rec.Status <> Rec.Status::Approved then begin

                    //     if Confirm('The document is not approved. Do you want to send it for approval?', true, false) then begin
                    //         RecRef.GetTable(Rec);
                    //         if CustomWorkflowMgmt.CheckApprovalsWorkflowEnabled(RecRef) then
                    //             CustomWorkflowMgmt.OnSendWorkflowForApproval(RecRef);
                    //         Message('The document has been sent for approval.');
                    //     end else
                    //         Message('Posting cancelled.');
                    //     exit;
                    // end;
                    if not Confirm('Do you want to post the car receipt?', true) then
                        Message('Posting cancelled.')
                    else begin

                        Rec.PostCarDetails(Rec);
                        Message('Car details posted successfully.');


                        CarLine.SetRange("Document No.", Rec.No);
                        if CarLine.FindFirst() then begin
                            VendorNo := CarLine."Received From";

                            // Find the latest purchase invoice for the vendor
                            PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
                            PurchaseHeader.SetRange("Posting Date", Rec."Date");

                            if PurchaseHeader.FindLast() then begin
                                PurchaseInvoiceNo := PurchaseHeader."No.";


                                Page.Run(Page::"Purchase Invoice", PurchaseHeader);
                            end else
                                Message('No purchase invoice was found for vendor: %1', VendorNo);
                        end else
                            Message('No car line record found for the current receiving header.');
                    end;
                end;
            }


            action(ImportCarDetails)
            {
                Caption = 'Import Car Details';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ImportCars: XmlPort "Import Car Details";
                begin
                    Clear(ImportCars);
                    ImportCars.GetDocNo(Rec.No);
                    ImportCars.Run();
                end;
            }
            action(ExportCarDetails)
            {
                Caption = 'Export Car Details';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ExportCars: XmlPort "Export Car Details";
                begin
                    Clear(ExportCars);
                    ExportCars.Run();
                end;
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;

                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    ToolTip = 'Send an approval request with the specified settings.', Comment = '%';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    trigger OnAction()

                    Var
                        CustomWorkflowMgmt: Codeunit "Custom Workflow Mgmt";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        if CustomWorkflowMgmt.CheckApprovalsWorkflowEnabled(RecRef) then
                            CustomWorkflowMgmt.OnSendWorkflowForApproval(RecRef);

                    end;



                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    trigger OnAction()

                    Var
                        CustomWorkflowMgmt: Codeunit "Custom Workflow Mgmt";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        CustomWorkflowMgmt.OnCancelWorkflowForApproval(RecRef);


                    end;
                }
            }

        }
        area(Creation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;

                    PromotedCategory = New;


                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = HasApprovalEntries;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;

    var
        NoFieldVisible: Boolean;
        PostCarDetails: Record "Car Line";
        CarRecivHead: Record "Car Recieving Header";
        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
}