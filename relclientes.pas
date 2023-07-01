unit relclientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet, DataModule;

type

  { TrelclientesF }

  TrelclientesF = class(TForm)
    btnRelCliente: TBitBtn;
    frDBrelClientes: TfrDBDataSet;
    frRelClientes: TfrReport;
    procedure btnRelClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  relclientesF: TrelclientesF;

implementation

{$R *.lfm}

{ TrelclientesF }

procedure TrelclientesF.btnRelClienteClick(Sender: TObject);
begin
  DataModuleF.qryCliente.open;
  frRelClientes.LoadFromFile('RelClientes.lrf');
  frRelClientes.PrepareReport;
  frRelClientes.ShowReport;
end;

procedure TrelclientesF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DataModuleF.qryCliente.close;
  CloseAction := caFree;
end;

end.

