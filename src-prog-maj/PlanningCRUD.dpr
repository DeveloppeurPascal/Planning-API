program PlanningCRUD;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uPlanning in 'uPlanning.pas',
  uChecksumVerif in '..\lib-externes\librairies\uChecksumVerif.pas',
  u_md5 in '..\lib-externes\librairies\u_md5.pas',
  uPlanningConsts in 'uPlanningConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
