namespace YardManagement.YardManagement;

using Microsoft.FixedAssets.FixedAsset;
using TableIntroduction.TableIntroduction;
using System.Device;
using System.IO;


page 90123 "Left side"
{
    // ApplicationArea = All;
    Caption = 'Specific Car Left Side Details';
    PageType = CardPart;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    SourceTable = "Fixed Asset";

    layout
    {
        area(Content)
        {

            group("Left")
            {
                Caption = 'Left';
                field("Left Side Picture"; Rec."Left Side Picture")
                {
                    ToolTip = 'Specifies the Left Side Picture.', Comment = '%';

                }
            }

        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField(Description);

                    if Rec."Left Side Picture".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;


                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Left Side Picture");

                    Rec."Left Side Picture".ImportFile(FileName, ClientFileName);

                    Rec.Modify(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField(Description);

                    ToFile := StrSubstNo('%1 %2.jpg', Rec."No.", Rec.Description);
                    ExportPath := TemporaryPath + Rec."No." + Format(Rec."Left Side Picture".MediaId);

                    OnExportFileActionOnAfterExportPath(Rec, ToFile, ExportPath);
                    Rec."Left Side Picture".ExportFile(ExportPath);


                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Left Side Picture");

                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable()
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField("No.");
        Rec.TestField(Description);

        if Rec."Left Side Picture".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;


        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec."Left Side Picture");

            Rec."Left Side Picture".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);

            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Left Side Picture".HasValue;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnExportFileActionOnAfterExportPath(FixedAsset: Record "Fixed Asset"; var ToFile: Text; var ExportPath: Text)
    begin
    end;


}
