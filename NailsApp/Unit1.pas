unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, Unit2, Unit3, Unit4, System.hash;

type
  TFormEntering = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntering: TFormEntering;

implementation

{$R *.fmx}

uses Unit5;

procedure TFormEntering.Button1Click(Sender: TObject);
var Users: TStringList; i: integer; CurrentUser: string;
begin
  Users:=TStringList.Create;
  Users.LoadFromFile('data/users.txt');
  i:=0;
  while i<Users.Count do
      begin
        if Edit1.Text=Users.Strings[i] then
        begin
           if Users.Strings[i+1]=System.Hash.THashMD5.GetHashString(Edit2.Text) then
           begin
              Panel2.Enabled:=true;
              ShowMessage('Вы вошли как '+Edit1.Text);
              CurrentUser:=Edit1.Text;
              FormClient.Caption:='NailsApp - Клиенты - ' + CurrentUser;
              FormClient.Current.Text:=CurrentUser;
              exit;
           end;
        end;
        i:=i+2;
      end;
  ShowMessage('Такого пользователя нет!');
end;

procedure TFormEntering.Button2Click(Sender: TObject);
begin
  FormRegistration.ShowModal;
end;

procedure TFormEntering.Button3Click(Sender: TObject);
begin
  FormClient.ShowModal;
end;

procedure TFormEntering.Button4Click(Sender: TObject);
begin
FormPricelist.ShowModal;
end;

procedure TFormEntering.Button5Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TFormEntering.FormCreate(Sender: TObject);
var f: textfile;
begin
  if not(DirectoryExists('data')) then
  begin
    ShowMessage('Нет нужных файлов для работы! Программа их сейчас создаст.');
    CreateDir('data');
    SetCurrentDir('data');
    AssignFile(f, 'users.txt');
    Rewrite(f);
    CloseFile(f);
    SetCurrentDir('../');
  end;
end;

end.
