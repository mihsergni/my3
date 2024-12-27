unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mmsystem, ComCtrls, ExtCtrls, jpeg, IniFiles;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    Edit7: TEdit;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Button3: TButton;
    Image1: TImage;
    Button4: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit6DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Probnaya(ii : integer);
  private
    { Private declarations }
  public
  pop, rez, prav, neprav : integer;
  vv : real;
  MAX, MIN : integer;
  mas : TStringList;
  procedure gener;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var x, y, z, pi, znak : integer;
label d, e;
begin

Randomize;

d:
pi:=Random(mas.Count-1);
//Проверрка
if mas.Count = 0 then
begin
gener;
goto d;
end;

e:
x:=Trunc(StrToInt(mas[pi])/10);
Edit1.Text:=IntToStr(x);

y:=StrToInt(mas[pi]) mod 10;
Edit2.Text:=IntToStr(y);

if pi <= mas.Count then
mas.Delete(pi);


znak := random(2);
if znak = 0 then
begin
Label2.Caption:='+';
rez:=x + y;
end else
begin
if x < y then goto e;

Label2.Caption:='-';
rez:=x - y;
end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var s : integer;
del : real;
begin


s:=StrToIntDef(Edit3.Text,-1);

if s = -1 then
begin
ShowMessage('Введи ответ !');
exit;
end;


if s = rez then
begin
Inc(prav);
sndPlaySound('mol.wav',SND_ASYNC);
//ShowMessage('М о л о д е ц ,    А н ю т а   ! ! !');
Button2.Click;pop:=0;Form1.Caption:='Математика для Анюты';
end
else
begin
Inc(neprav);Inc(pop);
sndPlaySound('fu.wav',SND_ASYNC);
if pop>=3 then Form1.Caption:='Подсказка: '+Edit1.Text+' * '+Edit2.Text+' = '+IntToStr(rez);
//ShowMessage('Ф у  -   ф у   -   ф у   ! ! !')
end;


Edit4.Text:=IntToStr(prav);
Edit5.Text:=IntToStr(neprav);

//Edit8.Text:=IntToStr(Trunc((prav)/2)-neprav);


Edit6.Text:=Format('%d',[Round(prav*10/(prav+neprav)/2)]);

vv:=prav*10./(prav+neprav)/2;
del:=vv - trunc(vv);
if (del <> 0) then
begin

Edit7.Text:=FloatToStr(vv);
if (del > 0.80) then
  Label5.Caption:=' '
  else if (del <= 0.80) and (del > 0.5) then
  Label5.Caption:='-'
  else if (del <= 0.5) then
  Label5.Caption:='+';
end;

if Round(vv) = 5 then
begin
StatusBar1.SimpleText:='Выдать сладкую конфету !';
Image1.Picture.LoadFromFile('R5.jpg');
end
else if Round(vv) = 4 then
begin
StatusBar1.SimpleText:='Выдать не очень сладкую конфету !';
Image1.Picture.LoadFromFile('R4.jpg');
end
else if Round(vv) = 3 then
begin
StatusBar1.SimpleText:='Выдать солёный огурец !';
Image1.Picture.LoadFromFile('R3.jpg');
end
else if Round(vv) = 2 then
begin
StatusBar1.SimpleText:='Дать ремнём по попе 10 раз !';
Image1.Picture.LoadFromFile('R2.jpg');
end
else if Round(vv) <= 1 then
begin
StatusBar1.SimpleText:='Выгнать из квартиры !';
Image1.Picture.LoadFromFile('R1.jpg');
end;

Edit3.Text:='';

Edit3.SetFocus;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Button2.Click;
prav:=0;neprav:=0;
sndPlaySound('start.wav',SND_ASYNC);
end;

procedure TForm1.Button3Click(Sender: TObject);
var ttt : integer;
begin

(*
if prav < 64 then begin
ShowMessage('Ты ответила меньше чем на 50 примеров.'+#13+'Поработай ещё !!!');
exit;
end;*)

//ttt:=StrToIntDef(Edit8.Text,0)*60*1000;

if Round(vv) = 5 then
sndPlaySound('5.wav',SND_SYNC)
else if Round(vv) = 4 then
sndPlaySound('4.wav',SND_SYNC)
else if Round(vv) = 3 then
sndPlaySound('3.wav',SND_SYNC)
else if Round(vv) = 2 then
sndPlaySound('2.wav',SND_SYNC)
else if Round(vv) = 1 then
sndPlaySound('1.wav',SND_SYNC);


//if ttt > 0 then
//begin
//Timer1.Interval:=ttt;
//Button4.Click;
//end else Close;
Close;

end;

procedure TForm1.Edit6DblClick(Sender: TObject);
begin
sndPlaySound('sp.wav',SND_ASYNC);
end;

procedure TForm1.FormCreate(Sender: TObject);
var Ini : TIniFile;
i, j : integer;
begin

mas:=TStringList.Create;
gener;


pop:=0;
Ini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'mat.ini');
MAX:=Ini.ReadInteger('main','MAX',9);
Ini.Free;



end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Timer1.Enabled:=true;
Form1.WindowState:=wsMinimized;
Form1.WindowState:=wsMinimized;

//UnLockSystem(lmInput); // Разблокировка клавы и мыши
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:=false;
Timer1.Enabled:=false;
Timer2.Enabled:=true;
Timer2.Enabled:=true;
LockSystem(lmInput); // Блокировка всей системы
//
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
UnLockSystem(lmInput); // Разблокировка клавы и мыши
Timer2.Enabled:=false;
Close;
end;

procedure TForm1.gener;
var i, j : integer;
begin
for i:=2 to 9 do
for j:=2 to 9 do
begin
mas.Add(IntToStr(i)+IntToStr(j));
//ShowMessage(IntToStr(i)+IntToStr(j));
end;

end;

procedure TForm1.Probnaya(ii: integer);
begin
ShowMessage('111');
ShowMessage('222');
ShowMessage('333');
end;

end.
