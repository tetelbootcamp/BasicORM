program BasicORM;

uses
  Vcl.Forms,
  U_Main in 'U_Main.pas' {Form1},
  model.teste in 'test\model.teste.pas',
  attributes in 'class\attributes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
