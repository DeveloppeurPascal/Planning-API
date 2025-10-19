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
  File last update : 2025-10-16T10:42:16.772+02:00
  Signature : b3c3d2fb0092520e434da26a579fe889d48a45c9
  ***************************************************************************
*)

unit uPlanningConsts;

interface

{$IFDEF DEBUG}

const
  CAuthToken = '{27934C3B-2F9B-46A7-9A26-4DE50404EE40}';
  CAddToken = '{9B257CE7-9C2D-4EE2-BEE4-0076418D0F15}';
  CChangedToken = '{8A97BCA1-AF2B-4D51-87FD-3E34EF95616A}';
  CRemoveToken = '{D3ABAE5C-074A-4B71-8116-2865418D8388}';
  CPlanningServerURL = 'http://localhost/WebPlanningAPI/';
{$MESSAGE WARN 'Remember to not use DEBUG token for production. Compile program in RELEASE mode.'}
{$ELSE}
{$I '..\_PRIVE\token.inc.pas'}
{$I '..\_PRIVE\consts.inc.pas'}
{$ENDIF}

implementation

end.
