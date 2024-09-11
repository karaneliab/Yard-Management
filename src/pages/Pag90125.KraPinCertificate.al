namespace YardManagement.YardManagement;

using Microsoft.FixedAssets.FixedAsset;
using TableIntroduction.TableIntroduction;
using System.Device;
using System.IO;


page 90125 "Kra Certificate"
{
    // ApplicationArea = All;
    Caption = 'Kra Pin Certificate';
    PageType = CardPart;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    SourceTable = 18;

    layout
    {
        area(Content)
        {

            group("K&ra Pin Certificate")
            {
                Caption = 'Kra Pin Certificate';
                field("Kra Pin Certificate"; Rec."Kra Pin Certificate")
                {
                    ToolTip = 'Specifies the Kra Pin Certificate.', Comment = '%';

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
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                    if Rec.Name = '' then
                        Error(MustSpecifyNameErr);

                    if Rec."Kra Pin Certificate".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Kra Pin Certificate");
                    Rec."Kra Pin Certificate".ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record Microsoft.Integration.Entity."Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField(Name);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Rec."No." + Format(Rec."Kra Pin Certificate".MediaId);
                    Rec."Kra Pin Certificate".ExportFile(ExportPath);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Kra Pin Certificate");
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
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a customer name before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Name);

        if Rec."Kra Pin Certificate".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec."Kra Pin Certificate");
            Rec."Kra Pin Certificate".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Kra Pin Certificate".HasValue;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;

}
