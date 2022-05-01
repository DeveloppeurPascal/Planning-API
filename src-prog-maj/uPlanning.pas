unit uPlanning;

interface

uses
  System.Classes, System.Generics.Collections, System.JSON;

type
  TPlanningEvent = class
  private
    FEventLabel: string;
    FEventStartDate: string;
    FEventType: string;
    FEventLanguage: string;
    FEventStopTime: string;
    FEventStartTime: string;
    FEventID: string;
    FEventURL: string;
    FisChanged: boolean;
    FisDeleted: boolean;
    procedure SetEventLabel(const Value: string);
    procedure SetEventLanguage(const Value: string);
    procedure SetEventStartDate(const Value: string);
    procedure SetEventStartTime(const Value: string);
    procedure SetEventStopTime(const Value: string);
    procedure SetEventType(const Value: string);
    procedure SetEventID(const Value: string);
    procedure SetEventURL(const Value: string);
    procedure SetisChanged(const Value: boolean);
    procedure SetisDeleted(const Value: boolean);
  public
    /// <summary>
    /// Unique ID of this event (used for Edit/Delete), given by the server during loading the list and after a create call
    /// </summary>
    property EventID: string read FEventID write SetEventID;
    /// <summary>
    /// Label of this event
    /// </summary>
    property EventLabel: string read FEventLabel write SetEventLabel;
    /// <summary>
    /// Type of this event : conference, webinar, Twitch, ...
    /// </summary>
    property EventType: string read FEventType write SetEventType;
    /// <summary>
    /// Date of this event
    /// </summary>
    property EventStartDate: string read FEventStartDate
      write SetEventStartDate;
    /// <summary>
    /// Start time of this event
    /// </summary>
    property EventStartTime: string read FEventStartTime
      write SetEventStartTime;
    /// <summary>
    /// End time (if known) of this event
    /// </summary>
    property EventStopTime: string read FEventStopTime write SetEventStopTime;
    /// <summary>
    /// Language to use during this event
    /// </summary>
    property EventLanguage: string read FEventLanguage write SetEventLanguage;
    /// <summary>
    /// Web site URL of this event
    /// </summary>
    property EventURL: string read FEventURL write SetEventURL;
    /// <summary>
    /// To know if this event has been changed since it's last save
    /// </summary>
    property isChanged: boolean read FisChanged write SetisChanged;
    /// <summary>
    /// To know if this event has been deleted since it's last save (and must be sent to the server)
    /// </summary>
    property isDeleted: boolean read FisDeleted write SetisDeleted;
    /// <summary>
    /// Create this event from its JSON representation
    /// </summary>
    constructor CreateFromJSONObject(JSON: TJSONObject);
    /// <summary>
    /// Export this event as its JSON string representation
    /// </summary>
    function ToJSON: string;
    /// <summary>
    /// Export this event as its JSON Object representation
    /// </summary>
    function ToJSONObject: TJSONObject;
  end;

  TPlanningReadyEvent = procedure of object;
  TPlanningAfterSaveEvent = procedure of object;
  TPlanningAPIErrorEvent = procedure(HTTPStatusCode: integer; ErrorText: string)
    of object;

  TPlanning = class(TObjectList<TPlanningEvent>)
  private
    FonReady: TPlanningReadyEvent;
    FonAfterSave: TPlanningAfterSaveEvent;
    FonCreateError: TPlanningAPIErrorEvent;
    FonSaveError: TPlanningAPIErrorEvent;
    procedure SetonReady(const Value: TPlanningReadyEvent);
    procedure SetonAfterSave(const Value: TPlanningAfterSaveEvent);
    procedure SetonCreateError(const Value: TPlanningAPIErrorEvent);
    procedure SetonSaveError(const Value: TPlanningAPIErrorEvent);
  protected
    /// <summary>
    /// API server URL
    /// </summary>
    FServerURL: string;
    procedure SendChangedEventsToServerURL(Events: TJSONArray);
    procedure SendNewEventToServerURL(Event: TPlanningEvent);
    procedure SendDeletedEventToServerURL(Event: TPlanningEvent);
  public
    /// <summary>
    /// Event raised when planning has been filled from the URL
    /// </summary>
    property onReady: TPlanningReadyEvent read FonReady write SetonReady;
    /// <summary>
    /// Event raised when the server responds with an error message or doesn't answer during loading the planning
    /// </summary>
    property onCreateError: TPlanningAPIErrorEvent read FonCreateError
      write SetonCreateError;
    /// <summary>
    /// Event raised when the server responds with an error message or doesn't answer during saving the changed events or new events
    /// </summary>
    property onSaveError: TPlanningAPIErrorEvent read FonSaveError
      write SetonSaveError;
    /// <summary>
    /// Event raised when save operation has finished
    /// (new and changed events have been sent and received from the server)
    /// </summary>
    // todo : how-to cal this
    property onAfterSave: TPlanningAfterSaveEvent read FonAfterSave
      write SetonAfterSave;
    /// <summary>
    /// Create and fill the event list from the URL
    /// </summary>
    constructor CreateFromURL(AURL: string; AonReady: TPlanningReadyEvent = nil;
      AonError: TPlanningAPIErrorEvent = nil);
    /// <summary>
    /// Create constructor to deny its usage...
    /// </summary>
    constructor Create; deprecated 'use CreateFrumURL';
    /// <summary>
    /// Send changed or created objects to the server
    /// </summary>
    procedure Save;
  end;

implementation

uses fmx.Types,
  System.SysUtils, System.Threading, System.Net.HttpClient, uPlanningConsts,
  uChecksumVerif;

const
  CEventLabelKey = 'label'; // property name for JSON object
  CEventTypeKey = 'type'; // property name for JSON object
  CEventStartDateKey = 'startdate'; // property name for JSON object
  CEventStartTimeKey = 'starttime'; // property name for JSON object
  CEventStopTimeKey = 'stoptime'; // property name for JSON object
  CEventLanguageKey = 'language'; // property name for JSON object
  CEventURLKey = 'url'; // property name for JSON object
  CEventUIDKey = 'uid'; // property name for JSON object

  { TPlanning }

constructor TPlanning.Create;
begin
  raise exception.Create('Use CreateFromURL method instead of Create.');
end;

constructor TPlanning.CreateFromURL(AURL: string; AonReady: TPlanningReadyEvent;
  AonError: TPlanningAPIErrorEvent);
begin
  if (AURL.IsEmpty) then
    raise exception.Create('API server URL needed !');

  inherited Create;

  FonReady := AonReady;
  FonCreateError := AonError;

  if AURL.EndsWith('/') then
    FServerURL := AURL
  else
    FServerURL := AURL + '/';

  ttask.Run(
    procedure
    var
      server: thttpclient;
      response: ihttpresponse;
      jsa: TJSONArray;
      jsv: tjsonvalue;
    begin
      server := thttpclient.Create;
      try
        try
          response := server.Get(FServerURL + 'events.php');
          if response.StatusCode = 200 then
          begin
            jsa := TJSONArray.ParseJSONValue(response.ContentAsString
              (TEncoding.UTF8)) as TJSONArray;
            if not assigned(jsa) then
              raise exception.Create('Server response is not a JSON array.')
            else
              try
                // if empty array, perhaps first call of this server
                if (jsa.Count > 0) then
                  for jsv in jsa do
                    if (jsv is TJSONObject) then
                      add(TPlanningEvent.CreateFromJSONObject
                        (jsv as TJSONObject));
                if assigned(onReady) then
                  tthread.Queue(nil,
                    procedure
                    begin
                      onReady;
                    end);
              finally
                jsa.Free;
              end;
          end
          else if assigned(onCreateError) then
            tthread.Queue(nil,
              procedure
              begin
                if response.ContentAsString.IsEmpty then
                  onCreateError(response.StatusCode, response.StatusText)
                else
                  onCreateError(response.StatusCode, response.ContentAsString);
              end);
        finally
          server.Free;
        end;
      except
        if assigned(onCreateError) then
          tthread.Queue(nil,
            procedure
            begin
              onCreateError(-1, 'planning creation error');
            end);
      end;
    end);
end;

procedure TPlanning.Save;
var
  i: integer;
  list: TJSONArray;
begin
  // Send changes to the server
  list := TJSONArray.Create;
  try
    for i := 0 to Count - 1 do
      if items[i].isChanged and (not items[i].isDeleted) and
        (not items[i].EventID.IsEmpty) then
        list.add(items[i].ToJSONObject);
    if (list.Count > 0) then
      SendChangedEventsToServerURL(list)
    else
      list.Free;
  except
    list.Free;
  end;

  // Send new events to the server
  for i := 0 to Count - 1 do
    if items[i].isChanged and (not items[i].isDeleted) and
      (items[i].EventID.IsEmpty) then
      SendNewEventToServerURL(items[i]);

  // Send deleted events to the server
  for i := 0 to Count - 1 do
    if items[i].isChanged and items[i].isDeleted then
      if (items[i].EventID.IsEmpty) then
        items[i].isChanged := false
      else
        SendDeletedEventToServerURL(items[i]);

  // TODO : call onAfterSave event when others all "Send" been closed
end;

procedure TPlanning.SendChangedEventsToServerURL(Events: TJSONArray);
begin
  if not assigned(Events) then
    raise exception.Create('No events to send to the serveur.');

  ttask.Run(
    procedure
    var
      server: thttpclient;
      response: ihttpresponse;
      params: tstringlist;
      jsa: TJSONArray;
      JSON: string;
    begin
      try
        server := thttpclient.Create;
        try
          try
            params := tstringlist.Create;
            try
              params.AddPair('auth', CAuthToken);
              JSON := Events.ToJSON;
              params.AddPair('events', JSON);
              params.AddPair('v', ChecksumVerif.Get(CAuthToken,
                CChangedToken, JSON));
              response := server.post(FServerURL + 'changedevents.php', params);
            finally
              params.Free;
            end;
            if response.StatusCode = 200 then
            begin
{$IFDEF DEBUG}
              log.d(response.ContentAsString);
{$ENDIF}
              jsa := TJSONArray.ParseJSONValue(response.ContentAsString
                (TEncoding.UTF8)) as TJSONArray;
              if not assigned(jsa) then
                raise exception.Create('Server response is not a JSON array.')
              else
                try
                  // if empty array, perhaps first call of this server
                  if (jsa.Count > 0) then
                    tthread.Synchronize(nil,
                      procedure
                      var
                        jsv: tjsonvalue;
                        i: integer;
                        ChangedEventID: string;
                      begin
                        for jsv in jsa do
                          if (jsv is TJSONString) then
                          begin
                            ChangedEventID := (jsv as TJSONString).Value;
                            for i := 0 to Count - 1 do
                              if (items[i].FEventID = ChangedEventID) then
                                items[i].isChanged := false;
                          end;
                      end);
                finally
                  jsa.Free;
                end;
              // TODO : taguer la fin du Save, donc appel de onSave
            end
            else if assigned(onSaveError) then
              tthread.Queue(nil,
                procedure
                begin
                  if response.ContentAsString.IsEmpty then
                    onSaveError(response.StatusCode, response.StatusText)
                  else
                    onSaveError(response.StatusCode, response.ContentAsString);
                end);
          finally
            server.Free;
          end;
        except
          if assigned(onCreateError) then
            tthread.Queue(nil,
              procedure
              begin
                onSaveError(-1, 'planning update error (can''t update items)');
              end);
        end;
      finally
        Events.Free;
      end;
    end);
end;

procedure TPlanning.SendDeletedEventToServerURL(Event: TPlanningEvent);
begin
  if not assigned(Event) then
    raise exception.Create('No removed event to send to the serveur.');

  ttask.Run(
    procedure
    var
      server: thttpclient;
      response: ihttpresponse;
      params: tstringlist;
    begin
      server := thttpclient.Create;
      try
        try
          params := tstringlist.Create;
          try
            params.AddPair('auth', CAuthToken);
            params.AddPair('id', Event.EventID);
            params.AddPair('v', ChecksumVerif.Get(CAuthToken, Cremovetoken,
              Event.EventID));
            response := server.post(FServerURL + 'rmvevent.php', params);
          finally
            params.Free;
          end;
          if response.StatusCode = 200 then
          begin
            Event.isChanged := false;
            // TODO : taguer la fin du Save, donc appel de onSave
          end
          else if assigned(onSaveError) then
            tthread.Queue(nil,
              procedure
              begin
                if response.ContentAsString.IsEmpty then
                  onSaveError(response.StatusCode, response.StatusText)
                else
                  onSaveError(response.StatusCode, response.ContentAsString);
              end);
        finally
          server.Free;
        end;
      except
        if assigned(onCreateError) then
          tthread.Queue(nil,
            procedure
            begin
              onSaveError(-1, 'planning update error (can''t remove item)');
            end);
      end;
    end);
end;

procedure TPlanning.SendNewEventToServerURL(Event: TPlanningEvent);
begin
  if not assigned(Event) then
    raise exception.Create('No new event to send to the serveur.');

  ttask.Run(
    procedure
    var
      server: thttpclient;
      response: ihttpresponse;
      params: tstringlist;
      JSON: string;
    begin
      server := thttpclient.Create;
      try
        try
          params := tstringlist.Create;
          try
            params.AddPair('auth', CAuthToken);
            JSON := Event.ToJSON;
            params.AddPair('event', JSON);
            params.AddPair('v', ChecksumVerif.Get(CAuthToken, CAddToken, JSON));
            response := server.post(FServerURL + 'newevent.php', params);
          finally
            params.Free;
          end;
          if response.StatusCode = 200 then
          begin
            Event.EventID := response.ContentAsString;
            // TODO : taguer la fin du Save, donc appel de onSave
          end
          else if assigned(onSaveError) then
            tthread.Queue(nil,
              procedure
              begin
                if response.ContentAsString.IsEmpty then
                  onSaveError(response.StatusCode, response.StatusText)
                else
                  onSaveError(response.StatusCode, response.ContentAsString);
              end);
        finally
          server.Free;
        end;
      except
        if assigned(onCreateError) then
          tthread.Queue(nil,
            procedure
            begin
              onSaveError(-1, 'planning update error (can''t add item)');
            end);
      end;
    end);
end;

procedure TPlanning.SetonAfterSave(const Value: TPlanningAfterSaveEvent);
begin
  FonAfterSave := Value;
end;

procedure TPlanning.SetonCreateError(const Value: TPlanningAPIErrorEvent);
begin
  FonCreateError := Value;
end;

procedure TPlanning.SetonReady(const Value: TPlanningReadyEvent);
begin
  FonReady := Value;
end;

procedure TPlanning.SetonSaveError(const Value: TPlanningAPIErrorEvent);
begin
  FonSaveError := Value;
end;

{ TPlanningEvent }

constructor TPlanningEvent.CreateFromJSONObject(JSON: TJSONObject);
begin
  Create;
  if not assigned(JSON) then
  begin
    FEventLabel := '';
    FEventStartDate := '';
    FEventType := '';
    FEventLanguage := '';
    FEventStopTime := '';
    FEventStartTime := '';
    FEventID := '';
    FEventURL := '';
  end
  else
  begin
    if not JSON.TryGetValue<string>(CEventLabelKey, FEventLabel) then
      FEventLabel := '';
    if not JSON.TryGetValue<string>(CEventStartDateKey, FEventStartDate) then
      FEventStartDate := '';
    if not JSON.TryGetValue<string>(CEventTypeKey, FEventType) then
      FEventType := '';
    if not JSON.TryGetValue<string>(CEventLanguageKey, FEventLanguage) then
      FEventLanguage := '';
    if not JSON.TryGetValue<string>(CEventStopTimeKey, FEventStopTime) then
      FEventStopTime := '';
    if not JSON.TryGetValue<string>(CEventStartTimeKey, FEventStartTime) then
      FEventStartTime := '';
    if not JSON.TryGetValue<string>(CEventUIDKey, FEventID) then
      FEventID := '';
    if not JSON.TryGetValue<string>(CEventURLKey, FEventURL) then
      FEventURL := '';
  end;
  FisChanged := false;
  FisDeleted := false;
end;

procedure TPlanningEvent.SetEventLabel(const Value: string);
begin
  FisChanged := FisChanged or (FEventLabel <> Value);
  FEventLabel := Value;
end;

procedure TPlanningEvent.SetEventLanguage(const Value: string);
begin
  FisChanged := FisChanged or (FEventLanguage <> Value);
  FEventLanguage := Value;
end;

procedure TPlanningEvent.SetEventStartDate(const Value: string);
begin
  FisChanged := FisChanged or (FEventStartDate <> Value);
  FEventStartDate := Value;
end;

procedure TPlanningEvent.SetEventStartTime(const Value: string);
begin
  FisChanged := FisChanged or (FEventStartTime <> Value);
  FEventStartTime := Value;
end;

procedure TPlanningEvent.SetEventStopTime(const Value: string);
begin
  FisChanged := FisChanged or (FEventStopTime <> Value);
  FEventStopTime := Value;
end;

procedure TPlanningEvent.SetEventType(const Value: string);
begin
  FisChanged := FisChanged or (FEventType <> Value);
  FEventType := Value;
end;

procedure TPlanningEvent.SetEventURL(const Value: string);
begin
  FisChanged := FisChanged or (FEventURL <> Value);
  FEventURL := Value;
end;

procedure TPlanningEvent.SetisChanged(const Value: boolean);
begin
  FisChanged := Value;
end;

procedure TPlanningEvent.SetisDeleted(const Value: boolean);
begin
  FisDeleted := Value;
  isChanged := true;
end;

function TPlanningEvent.ToJSON: string;
var
  jso: TJSONObject;
begin
  jso := ToJSONObject; // Self.ToJSONObject
  try
    result := jso.ToJSON;
  finally
    jso.Free;
  end;
end;

function TPlanningEvent.ToJSONObject: TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair(CEventUIDKey, FEventID);
  result.AddPair(CEventLabelKey, FEventLabel);
  result.AddPair(CEventTypeKey, FEventType);
  result.AddPair(CEventStartDateKey, FEventStartDate);
  result.AddPair(CEventStartTimeKey, FEventStartTime);
  result.AddPair(CEventStopTimeKey, FEventStopTime);
  result.AddPair(CEventLanguageKey, FEventLanguage);
  result.AddPair(CEventURLKey, FEventURL);
end;

procedure TPlanningEvent.SetEventID(const Value: string);
begin
  // Only changed by server request, so no local change to send to the server
  // FisChanged := FisChanged or (FEventID <> Value);
  FEventID := Value;
end;

end.
