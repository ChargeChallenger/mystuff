unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, System.hash, FMX.ScrollBox, FMX.Memo;

type
  TFormRegistration = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    StyleBook1: TStyleBook;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRegistration: TFormRegistration;

implementation

{$R *.fmx}

procedure TFormRegistration.Button1Click(Sender: TObject);
var Users: TStringList; i: integer; f: TextFile;
begin
  Users:=TStringList.Create;
  Users.LoadFromFile('data/users.txt');
  if (Edit1.Text<>'') and (Edit2.Text<>'') and (Edit3.Text<>'') then
  begin
    if Edit2.Text=Edit3.Text then
    begin
      i:=0;
      while i<Users.Count do
      begin
        if Edit1.Text=Users.Strings[i] then
        begin
          ShowMessage('����� ��� ��� ����!');
          exit;
        end;
        i:=i+2;
      end;
      Users.Add(Edit1.Text);
      Users.Add(System.Hash.THashMD5.GetHashString(Edit2.Text));
      Users.SaveToFile('data/users.txt');
      SetCurrentDir('data');
      CreateDir(Edit1.Text + 'Data');
      SetCurrentDir(Edit1.Text + 'Data');
      AssignFile(f, 'Clients.txt');
      Rewrite(f);
      CloseFile(f);
      AssignFile(f, 'Price.txt');
      Rewrite(f);
      CloseFile(f);
      SetCurrentDir('../');
      SetCurrentDir('../');
      ShowMessage('������� ������� ������!');
    end
    else
      ShowMessage ('�������� ������ �� ���������!');
  end
  else
    ShowMessage('������ ����!');
end;

procedure TFormRegistration.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Edit1.Text:=EmptyStr;
  Edit2.Text:=EmptyStr;
  Edit3.Text:=EmptyStr;
end;

end.
