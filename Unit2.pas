unit unit2;

interface
uses
  Windows;

type
  TLockMode = (lmInput, lmSystemKeys, lmBoth);

function FuncAvail(_dllname, _funcname: string; var _p: pointer): boolean;
function LockSystem(LockMode: TLockMode): Boolean;
function UnLockSystem(UnLockMode: TLockMode): Boolean;

var
  xBlockInput: function(Block: BOOL): BOOL; stdcall;

implementation

function FuncAvail(_dllname, _funcname: string; var _p: pointer): boolean;
var
  _lib: tHandle;
begin
  Result := false;
  _p := nil;
  if LoadLibrary(PChar(_dllname)) = 0 then
    exit;
  _lib := GetModuleHandle(PChar(_dllname));
  if _lib <> 0 then
  begin
    _p := GetProcAddress(_lib, PChar(_funcname));
    if _p <> nil then
      Result := true;
  end;
end;

function LockSystem(LockMode: TLockMode): Boolean;
begin
  Result := False;

  if LockMode = lmSystemKeys then //Locking system
    if not SystemParametersInfo(SPI_SCREENSAVERRUNNING, 1, nil, 0) then
      Exit;

  if LockMode = lmInput then //locking keyb and mouse
    if FuncAvail('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(true)
    else
      Exit;

  if LockMode = lmBoth then
  begin
//    if not SystemParametersInfo(SPI_SCREENSAVERRUNNING, 1, nil, 0) then
//      Exit;
    if FuncAvail('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(true)
    else
      Exit;
  end;

  Result := True;
end;

function UnLockSystem(UnLockMode: TLockMode): Boolean;
begin
  Result := False;

  if UnLockMode = lmSystemKeys then //UnLocking system
    if not SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, nil, 0) then
      Exit;

  if UnLockMode = lmInput then //unlocking keyb and mouse
    if FuncAvail('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(false)
    else
      Exit;

  if UnLockMode = lmBoth then
  begin
    if not SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, nil, 0) then
      Exit;
    if FuncAvail('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(false)
    else
      Exit;
  end;

  Result := True;
end;

end.
