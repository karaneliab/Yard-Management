namespace YardManagement.YardManagement;
using System.Automation;

codeunit 90101 "Custom Workflow Mgmt"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    procedure GetWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ' '));
    end;

    //  add events to library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), DATABASE::Microsoft.Sales.Customer."Car Recieving Header",
         GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), DATABASE::Microsoft.Sales.Customer."Car Recieving Header",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;

    // subscribe

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", OnSendWorkflowForApproval, '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", OnCancelWorkflowForApproval, '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;



    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));


    end;

    //  handle document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomWorkflowHdr: Record Microsoft.Sales.Customer."Car Recieving Header";
    begin
        case RecRef.Number of
            Database::Microsoft.Sales.Customer."Car Recieving Header":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate(Status, CustomWorkflowHdr.Status::Open);
                    CustomWorkflowHdr.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        CustomWorkflowHdr: Record Microsoft.Sales.Customer."Car Recieving Header";
    begin
        case RecRef.Number of
            Database::Microsoft.Sales.Customer."Car Recieving Header":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate(Status, CustomWorkflowHdr.Status::"Pending Approval");
                    CustomWorkflowHdr.Modify(true);
                    Variant := CustomWorkflowHdr;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        CustomWorkflowHdr: Record Microsoft.Sales.Customer."Car Recieving Header";
    begin
        case RecRef.Number of
            Database::Microsoft.Sales.Customer."Car Recieving Header":
                begin
                    ;
                    RecRef.SetTable(CustomWorkflowHdr);
                    ApprovalEntryArgument."Document No." := CustomWorkflowHdr."No";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomWorkflowHdr: Record Microsoft.Sales.Customer."Car Recieving Header";
    begin
        case RecRef.Number of
            Database::Microsoft.Sales.Customer."Car Recieving Header":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate(Status, CustomWorkflowHdr.Status::Approved);
                    CustomWorkflowHdr.Modify(true);
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        CustomWorkflowHdr: Record Microsoft.Sales.Customer."Car Recieving Header";
        v: Codeunit "Record Restriction Mgt.";
    begin
        case ApprovalEntry."Table ID" of
            Database::Microsoft.Sales.Customer."Car Recieving Header":
                begin
                    if CustomWorkflowHdr.Get(ApprovalEntry."Document No.") then begin
                        CustomWorkflowHdr.Validate(CustomWorkflowHdr.Status, CustomWorkflowHdr.Status::Rejected);
                        CustomWorkflowHdr.Modify(true)
                    end;
                end;
        end;

    end;

// subsibe to event predecessor
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        RecRef: RecordRef;
    begin
        case EventFunctionName of
            GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef):
                begin
                    WorkflowEventhandling.AddEventPredecessor(EventFunctionName, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef));
                end;
            GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef):
                begin
                    WorkflowEventHandling.AddEventPredecessor(EventFunctionName, GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef));
                end;
            else
                Error('Unexpected EventFunctionName: %1', EventFunctionName);

        end;

    end;

    var
        WorkflowMgt: Codeunit "Workflow Management";
        WorkflowEventhandling: Codeunit "Workflow Event Handling";
        RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of Car Receiving Header is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of a  Car Receiving Header is cancelled.';

}
