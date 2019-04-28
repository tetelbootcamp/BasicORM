unit model.teste;

interface

uses
  attributes,
  Interfaces.base,
  Rtti;

type
  [TNameTable('Teste')]
  TTeste = class(TTable)
  private
    FHabitantes: Integer;
    FDescricao: string;
    FRendaPerCapta: Currency;
    FId: Integer;
    FData: TDateTime;
    FEstado: string;
    procedure SetData(const Value: TDateTime);
    procedure SetDescricao(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetHabitantes(const Value: Integer);
    procedure SetId(const Value: Integer);
    procedure SetRendaPerCapta(const Value: Currency);
  public
    [TFieldPK]
    property Id: Integer read FId write SetId;
    property Estado: string read FEstado write SetEstado;
    property Descricao: string read FDescricao write SetDescricao;
    property Data: TDateTime read FData write SetData;
    property Habitantes: Integer read FHabitantes write SetHabitantes;
    property RendaPerCapta: Currency read FRendaPerCapta write SetRendaPerCapta;
  end;

implementation

{ TTeste }

procedure TTeste.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TTeste.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TTeste.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TTeste.SetHabitantes(const Value: Integer);
begin
  FHabitantes := Value;
end;

procedure TTeste.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TTeste.SetRendaPerCapta(const Value: Currency);
begin
  FRendaPerCapta := Value;
end;

end.
