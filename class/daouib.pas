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

    procedure ConfigParametro(AQuery: TFDQuery; AProp: TRttiProperty; AField: string;  ATable: TTable);
  public
    Qry: TFDQuery;

    constructor Create(ADatabase: TFDConnection; ATransaction: TFDTransaction);

    procedure CloseQuery;
    function ExecuteQuery: Integer;

    function Insert(ATabela: TTable): Integer;
    function Save(ATabela: TTable): Integer;
    function Delete(ATable: TTable): Integer;

    function InTransaction: Boolean;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation

uses
  Vcl.Forms;

{ TDaoUib }

procedure TDaoUib.CloseQuery;
begin
  Qry.Close;
  Qry.SQL.Clear;
end;

procedure TDaoUib.Commit;
begin
  FTransaction.Commit;
end;

procedure TDaoUib.ConfigParametro(AQuery: TFDQuery; AProp: TRttiProperty;
  AField: string; ATable: TTable);
begin
  with AQuery do
  begin
    case AProp.PropertyType.TypeKind of
      tkInt64,
      tkInteger:
      begin
        Params.ParamByName(AField).Value := AProp.GetValue(ATable).AsInteger;
      end;
      tkChar,
      tkString,
      tkUString:
      begin
        Params.ParamByName(AField).Value := AProp.GetValue(ATable).AsString;
      end;
      tkFloat:
      begin
         Params.ParamByName(AField).Value := AProp.GetValue(ATable).AsCurrency;
      end;
      tkVariant:
      begin
        Params.ParamByName(AField).Value := AProp.GetValue(ATable).AsVariant;
      end;
    else
      raise Exception.Create('Tipo de campo não conhecido: ' +
         AProp.PropertyType.ToString);
    end;
  end;
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

function TDaoUib.Delete(ATable: TTable): Integer;
var
  Comando: TFuncReflection;
begin
  //crio uma variável do tipo TFuncReflexao - um método anônimo
  Comando := function(ACampos: TFieldAnonymous): Integer
  var
    Campo: string;
    PropRtti: TRttiProperty;
  begin
    with Qry do
    begin
      close;
      SQL.Clear;
      sql.Add('Delete from ' + ACampos.NameTable);
      sql.Add('Where');

      //percorrer todos os campos da chave primária
      ACampos.Sep := '';
      for Campo in ACampos.PKs do
      begin
        sql.Add(ACampos.Sep+ Campo + '= :' + Campo);
        ACampos.Sep := ' and ';
        // setando os parâmetros
        for PropRtti in ACampos.TipoRtti.GetProperties do
          if CompareText(PropRtti.Name, Campo) = 0 then
            begin
              ConfigParametro(Qry, PropRtti, Campo, ATable);
            end;
      end;

      //executa delete
      Prepare();
      ExecSQL;
      Result := RowsAffected;
    end;
  end;

  //reflection da tabela e execução da query preparada acima.
  Result := ReflectionSQL(ATable, Comando);
end;

function TDaoUib.ExecuteQuery: Integer;
begin
    Qry.Prepare();
    Qry.ExecSQL;
    Result := Qry.RowsAffected;
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
