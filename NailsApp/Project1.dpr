program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {FormEntering},
  Unit2 in 'Unit2.pas' {FormRegistration},
  Unit3 in 'Unit3.pas' {FormClient};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormEntering, FormEntering);
  Application.CreateForm(TFormRegistration, FormRegistration);
  Application.CreateForm(TFormClient, FormClient);
  Application.Run;
end.
