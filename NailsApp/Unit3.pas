unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Menus;

type
  TFormClient = class(TForm)
    Database: TStringGrid;
    Name: TStringColumn;
    Address: TStringColumn;
    Date: TDateColumn;
    Number: TIntegerColumn;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure MenuItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClient: TFormClient;

implementation

{$R *.fmx}


procedure TFormClient.MenuItem2Click(Sender: TObject);
var Clients: TStringList; f: TextFile; i,k: Byte;
begin
  SetCurrentDir('data');
  SetCurrentDir(MenuItem2.Text+'Data');
  AssignFile(f, 'clients.txt');
  Rewrite(f);
  CloseFile(f);
  ShowMessage('Сохранено!');
  Clients:=TStringList.Create;
  Clients.LoadFromFile('clients.txt');
  for i := 0 to Database.RowCount-1 do
  begin
    for k := 0 to Database.ColumnCount-1 do Clients.Add(Database.Cells[k,i]);
  end;
  Clients.SaveToFile('clients.txt');
  Clients.Free;
end;

end.
