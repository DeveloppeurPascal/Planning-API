(* C2PP
  ***************************************************************************

  Planning API

  Copyright 2022-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://planningapi.olfsoftware.fr

  Project site :
  https://github.com/DeveloppeurPascal/Planning-API

  ***************************************************************************
  File last update : 2025-10-16T10:42:16.765+02:00
  Signature : 9d6b79b4e5bb7223081c682a0a949150a39cfd56
  ***************************************************************************
*)

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
