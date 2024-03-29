unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uPlanning,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Layouts, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.Effects, FMX.EditBox, FMX.NumberBox, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

type
  TfrmMain = class(TForm)
    EventsList: TListView;
    UserArray: TLayout;
    ToolBar1: TToolBar;
    btnSaveToServer: TButton;
    btnAddEvent: TButton;
    btnSaveToServerGlowEffect: TGlowEffect;
    CheckIfPlanningHasBeenSentToTheServer: TTimer;
    EventArray: TVertScrollBox;
    lblLabel: TLabel;
    edtLabel: TEdit;
    lblType: TLabel;
    edtType: TEdit;
    lblLanguage: TLabel;
    edtLanguage: TEdit;
    lblURL: TLabel;
    edtURL: TEdit;
    lblURLThumb: TLabel;
    edtURLThumb: TEdit;
    lblStartDate: TLabel;
    edtStartDate: TEdit;
    lblStartTime: TLabel;
    edtStartTime: TEdit;
    lblStoptime: TLabel;
    edtStopTime: TEdit;
    lblOrder: TLabel;
    edtOrder: TNumberBox;
    GridPanelLayout1: TGridPanelLayout;
    btnSave: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    lblComment: TLabel;
    edtComment: TMemo;
    btnDuplicateEvent: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveToServerClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddEventClick(Sender: TObject);
    procedure EventsListChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure CheckIfPlanningHasBeenSentToTheServerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDuplicateEventClick(Sender: TObject);
  private
    FEditedEvent: tplanningevent;
    FCloseWithoutSavingChanges: Boolean;
    { D�clarations priv�es }
    procedure APIErrorEvent(HTTPStatusCode: integer; ErrorText: string);
    procedure APISaveErrorEvent(HTTPStatusCode: integer; ErrorText: string);
    procedure APIReadyEvent;
    procedure APIAfterSave;
    procedure SetEditedEvent(const Value: tplanningevent);
    procedure initEventListItem(item: TListViewItem; event: tplanningevent);
  public
    { D�clarations publiques }
    Planning: tplanning;
    property EditedEvent: tplanningevent read FEditedEvent write SetEditedEvent;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uPlanningConsts, FMX.DialogService;

procedure TfrmMain.APIAfterSave;
begin
  // TODO : � completer
  // TODO : d�bloquer champs de saisie une fois la fin de la sauvegarde
end;

procedure TfrmMain.APIErrorEvent(HTTPStatusCode: integer; ErrorText: string);
begin
  showmessage(HTTPStatusCode.ToString + ' - ' + ErrorText);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Planning.hasChanged and not FCloseWithoutSavingChanges then
  begin
    CanClose := false;
    TDialogService.MessageDialog
      ('Planning not saved. Do you want to close without saving its changes ?',
      tmsgdlgtype.mtConfirmation, [tmsgdlgbtn.mbYes, tmsgdlgbtn.mbNo],
      tmsgdlgbtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = mryes then
        begin
          FCloseWithoutSavingChanges := true;
          Close;
        end
        else
          FCloseWithoutSavingChanges := false;
      end);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCloseWithoutSavingChanges := false;
  CheckIfPlanningHasBeenSentToTheServer.enabled := false;
  btnSaveToServerGlowEffect.enabled := false;
  EventArray.Visible := false;
  UserArray.enabled := false;
  EditedEvent := nil;
  Planning := tplanning.CreateFromURL(CPlanningServerURL, APIReadyEvent,
    APIErrorEvent);

  edtOrder.Min := low(int64);
  edtOrder.Max := high(int64);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Planning.Free;
end;

procedure TfrmMain.initEventListItem(item: TListViewItem;
event: tplanningevent);
begin
  item.Text := event.EventLabel;
  item.detail := event.EventType + ' | ' + event.EventStartDate + ' | ' +
    event.EventStarttime + ' | ' + event.EventStoptime;
  item.Tagobject := event;
end;

procedure TfrmMain.SetEditedEvent(const Value: tplanningevent);
begin
  if assigned(FEditedEvent) then
  begin
    // TODO : Il existe d�j� un truc en ajout ou mise � jour, doit-on l'�craser ?
  end;

  FEditedEvent := Value;

  if assigned(FEditedEvent) then
  begin
    edtLabel.Text := FEditedEvent.EventLabel;
    edtType.Text := FEditedEvent.EventType;
    edtLanguage.Text := FEditedEvent.EventLanguage;
    edtURL.Text := FEditedEvent.EventURL;
    edtURLThumb.Text := FEditedEvent.EventURLThumb;
    edtStartDate.Text := FEditedEvent.EventStartDate;
    edtStartTime.Text := FEditedEvent.EventStarttime;
    edtStopTime.Text := FEditedEvent.EventStoptime;
    edtOrder.Value := FEditedEvent.EventOrder;
    edtComment.Text := FEditedEvent.Eventcomment;
  end
  else
    EventsList.Selected := nil;
end;

procedure TfrmMain.APIReadyEvent;
var
  i: integer;
  item: TListViewItem;
begin
{$IFDEF DEBUG}
  showmessage('Chargement termin�. ' + Planning.Count.ToString +
    ' �v�nements dans le planning');
{$ENDIF}
  Planning.SortPlanningEvents;
  EventsList.Items.Clear;
  for i := 0 to Planning.Count - 1 do
    initEventListItem(EventsList.Items.Add, Planning[i]);

  UserArray.enabled := true;
end;

procedure TfrmMain.APISaveErrorEvent(HTTPStatusCode: integer;
ErrorText: string);
begin
  APIErrorEvent(HTTPStatusCode, ErrorText);
  // TODO : d�bloquer champs de saisie une fois la fin de la sauvegarde
end;

procedure TfrmMain.btnAddEventClick(Sender: TObject);
begin
  EditedEvent := nil;

  edtLabel.Text := '';
  edtType.Text := '';
  edtLanguage.Text := '';
  edtURL.Text := '';
  edtURLThumb.Text := '';
  edtStartDate.Text := '';
  edtStartTime.Text := '';
  edtStopTime.Text := '';
  edtOrder.Value := -1;
  edtComment.Text := '';

  EventArray.Visible := true;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  EventArray.Visible := false;
  EditedEvent := nil;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  TDialogService.MessageDialog('Remove this event ?',
    tmsgdlgtype.mtConfirmation, [tmsgdlgbtn.mbYes, tmsgdlgbtn.mbNo],
    tmsgdlgbtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    var
      event: tplanningevent;
    begin
      if (AResult = mryes) then
      begin
        if assigned(EditedEvent) then
        begin
          event := EditedEvent;
          event.isDeleted := true;
          if assigned(EventsList.Selected) and
            ((EventsList.Selected.Tagobject as tplanningevent) = event) then
            EventsList.Items.Delete(EventsList.ItemIndex);
        end;
        btnCancelClick(Sender);
      end;
      btnSaveToServerGlowEffect.enabled := Planning.hasChanged;
    end);
end;

procedure TfrmMain.btnDuplicateEventClick(Sender: TObject);
begin
  EditedEvent := nil;
  edtLabel.Text := 'COPY - ' + edtLabel.Text;
  // add the event
  btnSaveClick(Sender);
  // select the new event
  // EventsList.ItemIndex := EventsList.Items.Count - 1;
  EventsList.Selected := EventsList.Items[EventsList.Items.Count - 1];
  // edit the new event
  EventsListChange(Sender);
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  event: tplanningevent;
begin
  if assigned(EditedEvent) then
    event := EditedEvent
  else
  begin
    event := tplanningevent.CreateFromJSONObject(nil);
    Planning.Add(event);
  end;

  event.EventLabel := edtLabel.Text;
  event.EventType := edtType.Text;
  event.EventLanguage := edtLanguage.Text;
  event.EventURL := edtURL.Text;
  event.EventURLThumb := edtURLThumb.Text;
  event.EventStartDate := edtStartDate.Text;
  event.EventStarttime := edtStartTime.Text;
  event.EventStoptime := edtStopTime.Text;
  event.EventOrder := trunc(edtOrder.Value);
  event.Eventcomment := edtComment.Text;

  if assigned(EventsList.Selected) and (EventsList.Selected.Tagobject = event)
    and (EventsList.Selected is TListViewItem) then
    initEventListItem((EventsList.Selected as TListViewItem), event)
  else
    initEventListItem(EventsList.Items.Add, event);

  EventArray.Visible := false;
  EditedEvent := nil;

  btnSaveToServerGlowEffect.enabled := Planning.hasChanged;
end;

procedure TfrmMain.btnSaveToServerClick(Sender: TObject);
begin
  btnSaveToServer.enabled := false;
  CheckIfPlanningHasBeenSentToTheServer.enabled := true;
  Planning.onSaveError := APISaveErrorEvent;
  Planning.onAfterSave := APIAfterSave;
  // TODO : bloquer champs de saisie en attendant la fin de la sauvegarde
  Planning.Save;
end;

procedure TfrmMain.CheckIfPlanningHasBeenSentToTheServerTimer(Sender: TObject);
begin
  if (not Planning.hasChanged) then
  begin
    CheckIfPlanningHasBeenSentToTheServer.enabled := false;
    btnSaveToServerGlowEffect.enabled := false;
    btnSaveToServer.enabled := true;
    if assigned(Planning.onAfterSave) then
      Planning.onAfterSave;
  end;
end;

procedure TfrmMain.EventsListChange(Sender: TObject);
begin
  if assigned(EventsList.Selected) and assigned(EventsList.Selected.Tagobject)
    and (EventsList.Selected.Tagobject is tplanningevent) then
  begin
    EditedEvent := EventsList.Selected.Tagobject as tplanningevent;
    EventArray.Visible := true;
  end;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
TDialogService.PreferredMode := TDialogService.TPreferredMode.Async;

{$IFDEF MACOS}
globalusemetal := true;
{$ENDIF}

end.
