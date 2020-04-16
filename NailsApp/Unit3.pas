unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Menus, FMX.EditBox, FMX.NumberBox;

type
  TFormClient = class(TForm)
    Database: TStringGrid;
    Name: TStringColumn;
    Address: TStringColumn;
    Date: TDateColumn;
    Number: TIntegerColumn;
    NameEdit: TEdit;
    AddressEdit: TEdit;
    DateEdit: TDateEdit;
    AddBtn: TButton;
    RmvBtn: TButton;
    Current: TLabel;
    NumEdit: TEdit;
    procedure AddBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  f:TextFile;
  i:Integer;
implementation

{$R *.fmx}


procedure TFormClient.AddBtnClick(Sender: TObject);
begin
  Inc(i);
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
end;

procedure TFormClient.FormShow(Sender: TObject);
begin
  i:=-1;
  SetCurrentDir('data');
  SetCurrentDir(Current.Text + 'Data');
  if not FileExists('Clients.txt') then
  begin
  ShowMessage('��� ����� ���� ������. �������...');
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
    Database.Cells[0,i+1]:=NameA[i];
    Database.Cells[1,i+1]:=AddressA[i];
    Database.Cells[2,i+1]:=DateA[i];
    Database.Cells[3,i+1]:=NumEditA[i];
    Inc(i);
  end;
  CloseFile(f);
  SetCurrentDir('../');
end;

end.