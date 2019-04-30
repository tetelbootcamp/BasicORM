unit U_Test;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  attributes,
  model.teste;

type
  TF_Test = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Test: TF_Test;

implementation

{$R *.dfm}

procedure TF_Test.Button1Click(Sender: TObject);
var
  ATab: TTeste;
begin
  ATab := TTeste.Create;
  try
    Memo1.Clear;
    Memo1.Lines.Add(GetNameTable(ATab));
  finally
    ATab.Free;
  end;
end;

procedure TF_Test.Button2Click(Sender: TObject);
var
  ATab: TTeste;
  Pk: TResultArray;
  chave: string;
begin
  ATab := TTeste.Create;
  try
    Pk := GetPks(ATab);
     Memo1.Clear;
     for chave in Pk do
       Memo1.Lines.Add(chave);
  finally
    ATab.Free;
  end;
end;

end.
