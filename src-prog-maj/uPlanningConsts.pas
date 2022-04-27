unit uPlanningConsts;

interface

{$IFDEF DEBUG}

const
  CAuthToken = '{27934C3B-2F9B-46A7-9A26-4DE50404EE40}';
  CAddToken = '{9B257CE7-9C2D-4EE2-BEE4-0076418D0F15}';
  CChangedToken = '{8A97BCA1-AF2B-4D51-87FD-3E34EF95616A}';
  CRemoveToken = '{D3ABAE5C-074A-4B71-8116-2865418D8388}';
  CPlanningServerURL = 'http://localhost/WebPlanningAPI/';
{$ELSE}
{$I '..\_PRIVE\token.inc.pas'}
{$I '..\_PRIVE\consts.inc.pas'}
{$ENDIF}

implementation

end.
