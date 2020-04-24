unit attributes;

interface

uses
  Interfaces.base,
  System.RTTI;

type

  TResultArray = array of string;

  TFieldAnonymous = record
    NameTable: string;
    Sep: string; // <-- utilizada para a separação dos campos no SQL
    PKs: TResultArray; // chave primária
    TipoRtti: TRttiType;
  end;

  TFuncReflection = reference to function(AField: TFieldAnonymous): Integer;

  TNameTable = class(TCustomAttribute)
  private
    FNameTable : string;
  public
    constructor Create(aNameTable: string);
    property NameTable: string read FNameTable write FNameTable;
  end;

  TField = class(TCustomAttribute)
  public
    function IsPk: Boolean; virtual;
  end;

  TFieldPK = class(TField)
  public
    function IsPk: Boolean; override;
  end;

  //Reflection para os comandos Sql
  function ReflectionSQL(ATabela: TTable; AnoniComando: TFuncReflection): Integer;

  function GetPks(AObject : TObject) : TResultArray;
  function GetNameTable(AObject : TObject) : string;

implementation

function ReflectionSQL(ATabela: TTable; AnoniComando: TFuncReflection): Integer;
var
  AField: TFieldAnonymous;
  Context  : TRttiContext;
begin
  AField.NameTable := GetNameTable(ATabela);

  AField.PKs   := GetPks(ATabela);

  Context  := TRttiContext.Create;
  try
    AField.TipoRtti := Context.GetType( ATabela.ClassType );

    //executamos os comandos Sql através do método anônimo
    AField.Sep := '';
    Result := AnoniComando(AField);

  finally
    Context.free;
  end;
end;

function GetPks(AObject : TObject) : TResultArray;
var
  Context  : TRttiContext;
  TipoRtti : TRttiType;
  PropRtti : TRttiProperty;
  AtribRtti : TCustomAttribute;
  i: Integer;
begin

  Context  := TRttiContext.Create;
  TipoRtti := Context.GetType( AObject.ClassType );
  i:=0;
  for PropRtti in TipoRtti.GetProperties do
    for AtribRtti in PropRtti.GetAttributes do
      if AtribRtti Is TField then
        if (AtribRtti as TField).isPk then
        begin
          SetLength(Result, i+1);
          Result[i] := PropRtti.Name;
          inc(i);
        end;

  Context.Free;
end;

function GetNameTable(AObject : TObject) : string;
var
  Contexto  : TRttiContext;
  TipoRtti  : TRttiType;
  AtribRtti : TCustomAttribute;
begin

  Contexto  := TRttiContext.Create;
  TipoRtti := Contexto.GetType( AObject.ClassType );

  for AtribRtti in TipoRtti.GetAttributes do
      if AtribRtti Is TNameTable then
        begin
          Result := (AtribRtti as TNameTable).NameTable;
          Break;
        end;

  Contexto.Free;
end;

{ TTable }

constructor TNameTable.Create(aNameTable: string);
begin
  FNameTable := aNameTable;
end;

{ TFields }

function TField.IsPk: Boolean;
begin
  Result := False;
end;

{ TFieldsPK }

function TFieldPK.IsPk: Boolean;
begin
  Result := True;
end;

end.
