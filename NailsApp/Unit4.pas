unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Menus, FMX.EditBox, FMX.NumberBox,
  FMX.Memo;

type
  TFormPricelist = class(TForm)
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Label1: TLabel;
    NameEdit: TEdit;
    Label2: TLabel;
    PriceEdit: TEdit;
    AddBtn: TButton;
    RmvBtn: TButton;
    Panel2: TPanel;
    Current: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Database: TStringGrid;
    Name: TStringColumn;
    Price: TStringColumn;
    procedure AddBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteRow(ARow: Integer);
    procedure DatabaseCellClick(const Column: TColumn; const Row: Integer);
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

procedure TFormPriceList.DatabaseCellClick(const Column: TColumn;
  const Row: Integer);
begin
  Row4Del:=Row;
end;

procedure TFormPriceList.DeleteRow(ARow: Integer);
var i, j: Integer;
begin
  with Database do
    begin
      for i:=ARow+1 to RowCount-1 do
      for j:=0 to Database.ColumnCount-1 do Cells[j, i-1]:=Cells[j, i];
      for i:=0 to Database.ColumnCount-1 do Cells[i, RowCount-1]:='';
      RowCount:=RowCount-1;
  end;
end;

procedure TFormPriceList.AddBtnClick(Sender: TObject);
begin
  if NameEdit.Text='' then ShowMessage('Заполните поле ФИО') else
  if PriceEdit.Text='' then ShowMessage('Заполните поле адреса') else
  begin
    NameA[i]:=NameEdit.Text;
    PriceA[i]:=PriceEdit.Text;
    Database.Cells[0,i]:=NameA[i];
    Database.Cells[1,i]:=PriceA[i];
    SetCurrentDir('data');
    SetCurrentDir(Current.Text + 'Data');
    AssignFile(f, 'price.txt');
    Append(f);
    Writeln(f, NameA[i]);
    Writeln(f, PriceA[i]);
    CloseFile(f);
    SetCurrentDir('../');
    SetCurrentDir('../');
    Inc(i);
  end;
end;

procedure TFormPriceList.RmvBtnClick(Sender: TObject);
var price: TStringList;
begin
  if (Database.Cells[0,Row4Del]='') and (Database.Cells[1,Row4Del]='') then Row4Del:=-1;
  if Row4Del=-1 then ShowMessage('Выберите строку для удаления!') else
    begin
    SetCurrentDir('data');
    SetCurrentDir(Current.Text + 'Data');
    price:=TStringList.Create;
    price.LoadFromFile('price.txt');
    price.Delete(Row4Del);
    price.Delete(Row4Del);
    price.SaveToFile('price.txt');
    price.Free;
    FormPriceList.DeleteRow(Row4Del);
    i:=i-1;
    Row4Del:=-1;
    end;
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
    Database.Cells[0,i]:=NameA[i];
    Database.Cells[1,i]:=PriceA[i];
    Inc(i);
  end;
  CloseFile(f);
  SetCurrentDir('../');
  SetCurrentDir('../');
end;

end.
