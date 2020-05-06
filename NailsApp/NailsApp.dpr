program NailsApp;





uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in '..\NailsApp\Unit1.pas' {FormEntering},
  Unit2 in '..\NailsApp\Unit2.pas' {FormRegistration},
  Unit3 in '..\NailsApp\Unit3.pas' {FormClient},
  Unit4 in '..\NailsApp\Unit4.pas' {FormPricelist},
  Unit5 in '..\NailsApp\Unit5.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormEntering, FormEntering);
  Application.CreateForm(TFormRegistration, FormRegistration);
  Application.CreateForm(TFormClient, FormClient);
  Application.CreateForm(TFormPricelist, FormPricelist);
  Application.CreateForm(TFormPricelist, FormPricelist);
  Application.CreateForm(TFormPricelist, FormPricelist);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
