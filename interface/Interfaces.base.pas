unit Interfaces.base;

interface

uses classes,
  attributes;

type
  IDataBase = interface
    ['{3B684242-7EC2-4851-BAE1-AD4B91998650}']
  end;

  ITransaction = interface
    ['{33CE423B-34C7-4C24-AC4B-BB0C1EF6BA3E}']
  end;

  TTable = class(TObject)

  end;

  IDaoBase = interface
    ['{CE25E2C5-4243-4C4E-881C-27FA50FDEBD3}']

    function Insert(ATabela: TTable): Integer;
    function Save(ATabela: TTable): Integer;
    function Delete(ATabela: TTable): Integer;

    function InTransaction: Boolean;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation

end.
