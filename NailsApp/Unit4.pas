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
    Address: TStringColumn;
    NameEdit: TEdit;
    AddressEdit: TEdit;
    AddBtn: TButton;
    RmvBtn: TButton;
    Current: TLabel;
    DeliteEdit: TEdit;
    procedure AddBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RmvBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPricelist: TFormPricelist;
  NameA: array [0..1000] of string;
  PriceA: array [0..1000] of string;
  f:TextFile;
  i:Integer;
implementation

{$R *.fmx}


procedure TFormPricelist.AddBtnClick(Sender: TObject);
begin
  Inc(i);
  NameA[i]:=NameEdit.Text;
  PriceA[i]:=AddressEdit.Text;
  Database.Cells[0,i]:=NameA[i];
  Database.Cells[1,i]:=PriceA[i];
  SetCurrentDir('data');
  SetCurrentDir(Current.Text + 'Data');
  AssignFile(f, 'Clients.txt');
  Append(f);
  Writeln(f, NameA[i]);
  Writeln(f, PriceA[i]);
  CloseFile(f);
  SetCurrentDir('../');
end;

procedure TFormPricelist.FormShow(Sender: TObject);
begin
  i:=-1;
  SetCurrentDir('data');
  SetCurrentDir(Current.Text + 'Data');
  if not FileExists('Pricelist.txt') then
  begin
  ShowMessage('Нет файла базы данных. Создаем...');
  AssignFile(f, 'Pricelist.txt');
  Rewrite(f);
  CloseFile(f);
  end;
  AssignFile(f, 'Pricelist.txt');
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

procedure TFormPricelist.RmvBtnClick(Sender: TObject);
var i1,del:integer;
begin
del:=StrToInt(deliteEdit.Text);
for i1:=1 to i do
  if i1=del then
  begin
  Database.Cells[0,i-1]:=Database.Cells[0,i];
  Database.Cells[1,i-1]:=Database.Cells[1,i];
  end
  else
    begin
  Database.Cells[0,i-1]:='';
  Database.Cells[1,i-1]:='';
  end;
 i:=i-1;
end;

end.
