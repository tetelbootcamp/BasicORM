unit attributes;

interface

uses
  Interfaces.base, Rtti;

type

  TResultArray = array of string;

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

  function GetPks(AObject : TObject) : TResultArray;
  function GetNameTable(AObject : TObject) : string;

implementation

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
