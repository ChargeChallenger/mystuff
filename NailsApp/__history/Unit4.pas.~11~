unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Menus, FMX.EditBox, FMX.NumberBox;

type
  TFormPricelist = class(TForm)
    Database: TStringGrid;
    Name: TStringColumn;
    NameEdit: TEdit;
    PriceEdit: TEdit;
    AddBtn: TButton;
    RmvBtn: TButton;
    Current: TLabel;
    procedure AddBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteRow(ARow: Integer);
    procedure DatabaseSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure RmvBtnClick(Sender: TObject);

  private
    { Private declarations }
 public
    { Public declarations }
  end;

var
  FormPriceList: TFormPriceList;
  NameA: array [0..1000] of string;
  PriceA: array [0..1000] of string;
  Row4Del: Integer;
  f:TextFile;
  i:Integer;
implementation

{$R *.fmx}


procedure TFormPriceList.DatabaseSelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  FormPriceList.RmvBtn.Text:='Удалить выбранную стро';
  Row4Del:=ARow;
end;

procedure TFormPriceList.DeleteRow(ARow: Integer);
var i, j: Integer;
begin
with Database do
  begin
    for i:=ARow+1 to RowCount-1 do
    for j:=0 to Database.ColumnCount-1 do
      Cells[j, i-1]:=Cells[j, i];
    for i:=0 to Database.ColumnCount-1 do
      Cells[i, RowCount-1]:='';
    RowCount:=RowCount-1;
  end;
end;

procedure TFormPriceList.AddBtnClick(Sender: TObject);
begin
  if NameEdit.Text='' then ShowMessage('Заполните поле услуги') else
  if PriceEdit.Text='' then ShowMessage('Заполните поле цены') else
  begin
    NameA[i]:=NameEdit.Text;
    PriceA[i]:=PriceEdit.Text;
    Database.Cells[0,i]:=NameA[i];
    Database.Cells[1,i]:=PriceA[i];
    SetCurrentDir('data');
    SetCurrentDir(Current.Text + 'Data');
    AssignFile(f, 'Price.txt');
    Append(f);
    Writeln(f, NameA[i]);
    Writeln(f, PriceA[i]);
    CloseFile(f);
    SetCurrentDir('../');
    Inc(i);
  end;
end;

procedure TFormPriceList.RmvBtnClick(Sender: TObject);
var Clients: TStringList;
begin
  SetCurrentDir('data');
  SetCurrentDir(Current.Text + 'Data');
  Clients:=TStringList.Create;
  Clients.LoadFromFile('Price.txt');
  Clients.Delete(Row4Del);
  Clients.Delete(Row4Del);
  Clients.SaveToFile('Price.txt');
  Clients.Free;
  FormPriceList.DeleteRow(Row4Del);
 i:=i-1;
end;

procedure TFormPriceList.FormShow(Sender: TObject);
begin
  i:=0;
  SetCurrentDir('data');
  SetCurrentDir(Current.Text + 'Data');
  if not FileExists('Price.txt') then
  begin
  ShowMessage('Нет файла базы данных. Создаем...');
  AssignFile(f, 'Price.txt');
  Rewrite(f);
  CloseFile(f);
  end;
  AssignFile(f, 'Price.txt');
  Reset(f);
  while not EOF(f) do
  begin
    Readln(f, NameA[i]);
    Readln(f, PriceA[i]);
    Database.Cells[0,i+1]:=NameA[i];
    Database.Cells[1,i+1]:=PriceA[i];
    Inc(i);
  end;
  CloseFile(f);
  SetCurrentDir('../');
end;

end.
