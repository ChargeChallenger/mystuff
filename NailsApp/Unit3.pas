unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Menus, FMX.EditBox, FMX.NumberBox,
  FMX.Memo;

type
  TFormClient = class(TForm)
    Database: TStringGrid;
    Name: TStringColumn;
    Address: TStringColumn;
    Date: TDateColumn;
    Number: TStringColumn;
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Label1: TLabel;
    NameEdit: TEdit;
    Label2: TLabel;
    AddressEdit: TEdit;
    Label3: TLabel;
    DateEdit: TDateEdit;
    Label4: TLabel;
    NumEdit: TEdit;
    AddBtn: TButton;
    RmvBtn: TButton;
    Panel2: TPanel;
    Current: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure AddBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteRow(ARow: Integer);
    procedure RmvBtnClick(Sender: TObject);
    procedure DatabaseCellClick(const Column: TColumn; const Row: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClient: TFormClient;
  NameA: array [0..1000] of string;
  AddressA: array [0..1000] of string;
  DateA: array [0..1000] of string;
  NumEditA: array [0..1000] of string;
  Row4Del: Integer;
  f:TextFile;
  i:Integer;
implementation

{$R *.fmx}


procedure TFormClient.DatabaseCellClick(const Column: TColumn;
  const Row: Integer);
begin
  Row4Del:=Row;
end;

procedure TFormClient.DeleteRow(ARow: Integer);
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

procedure TFormClient.AddBtnClick(Sender: TObject);
begin
  if NameEdit.Text='' then ShowMessage('Заполните поле ФИО') else
  if AddressEdit.Text='' then ShowMessage('Заполните поле адреса') else
  if NumEdit.Text='' then ShowMessage('Заполните поле номера телефона') else
  begin
    NameA[i]:=NameEdit.Text;
    AddressA[i]:=AddressEdit.Text;
    DateA[i]:=DateToStr(DateEdit.Date);
    NumEditA[i]:=NumEdit.Text;
    Database.Cells[0,i]:=NameA[i];
    Database.Cells[1,i]:=AddressA[i];
    Database.Cells[2,i]:=DateA[i];
    Database.Cells[3,i]:=NumEditA[i];
    SetCurrentDir('data');
    SetCurrentDir(Current.Text + 'Data');
    AssignFile(f, 'Clients.txt');
    Append(f);
    Writeln(f, NameA[i]);
    Writeln(f, AddressA[i]);
    Writeln(f, DateA[i]);
    Writeln(f, NumEditA[i]);
    CloseFile(f);
    SetCurrentDir('../');
    SetCurrentDir('../');
    Inc(i);
  end;
end;

procedure TFormClient.RmvBtnClick(Sender: TObject);
var Clients: TStringList;
begin
  if (Database.Cells[0,Row4Del]='') and (Database.Cells[1,Row4Del]='') and (Database.Cells[2,Row4Del]='') and (Database.Cells[3,Row4Del]='') then Row4Del:=-1;
  if Row4Del=-1 then ShowMessage('Выберите строку для удаления!') else
    begin
    SetCurrentDir('data');
    SetCurrentDir(Current.Text + 'Data');
    Clients:=TStringList.Create;
    Clients.LoadFromFile('Clients.txt');
    Clients.Delete(Row4Del);
    Clients.Delete(Row4Del);
    Clients.Delete(Row4Del);
    Clients.Delete(Row4Del);
    Clients.SaveToFile('Clients.txt');
    Clients.Free;
    FormClient.DeleteRow(Row4Del);
    i:=i-1;
    Row4Del:=-1;
    end;
end;

procedure TFormClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  NameEdit.Text:=EmptyStr;
  AddressEdit.Text:=EmptyStr;
  NumEdit.Text:=EmptyStr;
  DateEdit.Text:='01.01.2000';
end;

procedure TFormClient.FormShow(Sender: TObject);
begin
  i:=0;
  SetCurrentDir('data/' + Current.Text + 'Data');
  if not FileExists('Clients.txt') then
  begin
  ShowMessage('Нет файла базы данных. Создаем...');
  AssignFile(f, 'Clients.txt');
  Rewrite(f);
  CloseFile(f);
  end;
  AssignFile(f, 'Clients.txt');
  Reset(f);
  while not EOF(f) do
  begin
    Readln(f, NameA[i]);
    Readln(f, AddressA[i]);
    Readln(f, DateA[i]);
    Readln(f, NumEditA[i]);
    Database.Cells[0,i]:=NameA[i];
    Database.Cells[1,i]:=AddressA[i];
    Database.Cells[2,i]:=DateA[i];
    Database.Cells[3,i]:=NumEditA[i];
    Inc(i);
  end;
  CloseFile(f);
  SetCurrentDir('../');
  SetCurrentDir('../');
end;

end.
