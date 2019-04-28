unit attributes;

interface

type

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

implementation

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
