unit daouib;

interface

uses Interfaces.base,
     Rtti,
     attributes,
     system.SysUtils,
     System.Classes,
     Data.DB,
     FireDAC.Comp.Client,
     FireDAC.Stan.Param,
     FireDAC.DatS,
     FireDAC.DApt.Intf,
     FireDAC.DApt,
     FireDAC.Comp.DataSet;

type

  TDaoUib = class(TInterfacedObject, IDaoBase)
  private
    FDatabase: TFDConnection;
    FTransaction: TFDTransaction;
  public
    Qry: TFDQuery;

    constructor Create(ADatabase: TFDConnection; ATransaction: TFDTransaction);

    function Insert(ATabela: TTable): Integer;
    function Save(ATabela: TTable): Integer;
    function Delete(ATabela: TTable): Integer;

    function InTransaction: Boolean;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation

uses
  Vcl.Forms;

{ TDaoUib }

procedure TDaoUib.Commit;
begin
  FTransaction.Commit;
end;

constructor TDaoUib.Create(ADatabase: TFDConnection;
  ATransaction: TFDTransaction);
begin
  if not Assigned(ADatabase) then
    raise Exception.Create('Database não informado!');

  if not Assigned(ATransaction) then
    raise Exception.Create('Transaction não informado!');

  FDatabase := ADatabase;
  FTransaction := ATransaction;

  Qry := TFDQuery.Create(Application);
  Qry.Connection  := FDatabase;
  Qry.Transaction := FTransaction;
end;

function TDaoUib.Delete(ATabela: TTable): Integer;
begin

end;

function TDaoUib.Insert(ATabela: TTable): Integer;
begin

end;

function TDaoUib.InTransaction: Boolean;
begin
  Result := FDatabase.InTransaction;
end;

procedure TDaoUib.RollBack;
begin
  FTransaction.RollBack;
end;

function TDaoUib.Save(ATabela: TTable): Integer;
begin

end;

procedure TDaoUib.StartTransaction;
begin
  FTransaction.StartTransaction;
end;

end.
