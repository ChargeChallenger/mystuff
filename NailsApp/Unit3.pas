unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.StdCtrls, FMX.DateTimeCtrls;

type
  TFormClient = class(TForm)
    Database: TStringGrid;
    LabelName: TLabel;
    LabelLName: TLabel;
    ClientName: TEdit;
    ClientLName: TEdit;
    Date: TDateEdit;
    AddBtn: TButton;
    RemoveBtn: TButton;
    CurrentUser: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClient: TFormClient;

implementation

{$R *.fmx}

end.
