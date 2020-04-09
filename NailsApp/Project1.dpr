program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {FormEntering},
  Unit2 in 'Unit2.pas' {FormRegistration};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormEntering, FormEntering);
  Application.CreateForm(TFormRegistration, FormRegistration);
  Application.Run;
end.
