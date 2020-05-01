unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.StdCtrls, FMX.DateTimeCtrls, FMX.Edit,
  FMX.ComboEdit, FMX.ScrollBox, FMX.Controls.Presentation, FMX.Calendar;

type
  TForm5 = class(TForm)
    Calendar1: TCalendar;
    StringGrid1: TStringGrid;
    ComboEdit1: TComboEdit;
    ComboEdit2: TComboEdit;
    TimeEdit1: TTimeEdit;
    Календарь: TLabel;
    График: TLabel;
    Время: TLabel;
    Клиент: TLabel;
    Услуга: TLabel;
    Button1: TButton;
    DateColumn1: TDateColumn;
    TimeColumn1: TTimeColumn;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    Button2: TButton;
    Label1: TLabel;
    AddButton: TButton;
    Label2: TLabel;
    procedure Calendar1DayClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure StringGrid1CellClick(const Column: TColumn; const Row: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  SelectedDate: TDate;
  SelectedRow: integer;

implementation

{$R *.fmx}

procedure TForm5.AddButtonClick(Sender: TObject);
begin
  if not (Label1.Text='') then
  begin
    StringGrid1.RowCount:=StringGrid1.RowCount+1;
    StringGrid1.Cells[0,StringGrid1.RowCount-1]:=DateTimeToStr(SelectedDate);
    StringGrid1.Cells[1,StringGrid1.RowCount-1]:=DateTimeToStr(TimeEdit1.Time);
    StringGrid1.Cells[2,StringGrid1.RowCount-1]:=ComboEdit1.Text;
    StringGrid1.Cells[3,StringGrid1.RowCount-1]:=ComboEdit2.Text;
  end else
  ShowMessage('Не выбрана дата!');
end;

procedure TForm5.Button1Click(Sender: TObject);
var i: integer;
begin
  for i := SelectedRow to StringGrid1.RowCount-1 do
  begin
    StringGrid1.Cells[0,i]:=StringGrid1.Cells[0,i+1];
    StringGrid1.Cells[1,i]:=StringGrid1.Cells[1,i+1];
    StringGrid1.Cells[2,i]:=StringGrid1.Cells[2,i+1];
    StringGrid1.Cells[3,i]:=StringGrid1.Cells[3,i+1];
  end;
  StringGrid1.RowCount:=StringGrid1.RowCount-1;
end;

procedure TForm5.Button2Click(Sender: TObject);
var List: TStringList; i, j: integer;
begin
  list:=TStringList.Create;
  for i := 0 to StringGrid1.RowCount do
  for j := 0 to 3 do
  list.Add(StringGrid1.Cells[j,i]);
  SetCurrentDir('data/'+Label2.Text+'Data');
  list.SaveToFile('Day_'+DateTimeToStr(SelectedDate)+'.txt');
  SetCurrentDir('../');
  SetCurrentDir('../');
end;

procedure TForm5.Calendar1DayClick(Sender: TObject);
var list: TStringList; i, j: integer; switch: boolean;
begin
  StringGrid1.RowCount:=0;
  SelectedDate:=Calendar1.Date;
  list:=TStringList.Create;
  if FileExists('data/'+Label2.Text+'Data/Day_'+DateTimeToStr(SelectedDate)+'.txt') then
  begin
    list.LoadFromFile('data/'+Label2.Text+'Data/Day_'+DateTimeToStr(SelectedDate)+'.txt');
    for i := 0 to StringGrid1.RowCount do
    begin
    switch:=True;
      for j := 0 to 3 do
      begin
        if switch=True then
        begin
          StringGrid1.RowCount:=StringGrid1.RowCount+1;
          switch:=False;
        end;
        StringGrid1.Cells[j,i]:=list.Strings[StringGrid1.RowCount-1];
      end;
    end;
  end;
  Label1.Text:=' на '+DateTimeToStr(SelectedDate);
end;

procedure TForm5.StringGrid1CellClick(const Column: TColumn;
  const Row: Integer);
begin
  SelectedRow:=Row;
end;

end.
