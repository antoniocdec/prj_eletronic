unit bc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LazSerial, TAGraph, TASeries, Forms, Controls,
  Graphics, Dialogs, StdCtrls, sobre;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnParaCom: TButton;
    btnAtivarCom: TButton;
    Button1: TButton;
    Chart1: TChart;
    ChartLineSerieB: TLineSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LazSerial1: TLazSerial;
    Memo1: TMemo;
    procedure btnParaComClick(Sender: TObject);
    procedure btnAtivarComClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LazSerial1RxData(Sender: TObject);
  private

  public

  end;

var
  x:real;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }






procedure TForm1.LazSerial1RxData(Sender: TObject);
var
  fim: boolean;
  Leitura,Dado, Tipo, Nivel:string;
  mag:real;

  y:integer;
  t:longint;

begin

  Leitura:= LazSerial1.ReadData;
  Dado:=Trim(Leitura);
  memo1.Lines.Add(Dado);

  Tipo:=copy (dado,1,1);
  if x=0 then
  begin
     ChartLineSerieB.AddXY(0,0);
     ChartLineSerieB.AddXY(10,0);
     ChartLineSerieB.AddXY(0,0);
     ChartLineSerieB.AddXY(0,1025);
  end;
  x:=x+0.0176;

  if Tipo = 'S' then
  begin
   if (x>10)  then
     begin
       x:=0;
       ChartLineSerieB.Clear;


     end;
     end;
   Nivel:=copy(dado,2,length(dado)-1);

   t:=length(dado);

   if (length(dado)>1)and(length(dado)<5)  then
   begin
      y:=strtoint(Nivel);
      ChartLineSerieB.AddXY(x,y);
   end;

  if Tipo='B' then
  begin

    Label2.Caption:=copy(dado,2,3);
  end;

  if Tipo='Q' then
  begin
    Label4.Caption:=copy(dado,2,length(dado)-1);
  end;




end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  x:=0;
  // LazSerial1.Open;
end;

procedure TForm1.btnParaComClick(Sender: TObject);
begin
   LazSerial1.Close;
end;

procedure TForm1.btnAtivarComClick(Sender: TObject);
begin
  LazSerial1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

end.

