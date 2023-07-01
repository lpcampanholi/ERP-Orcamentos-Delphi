unit relorcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, DataModule;

type

  { TrelorcamentosF }

  TrelorcamentosF = class(TForm)
    btnRelOrcamentos: TBitBtn;
    frDBrelOrcamentos: TfrDBDataSet;
    frRelOrcamentos: TfrReport;
    procedure btnRelOrcamentosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  relorcamentosF: TrelorcamentosF;

implementation

{$R *.lfm}

{ TrelorcamentosF }

procedure TrelorcamentosF.btnRelOrcamentosClick(Sender: TObject);
begin
  DataModuleF.qryOrcamento.open;
  frRelOrcamentos.LoadFromFile('RelProdutos.lrf');
  frRelOrcamentos.PrepareReport;
  frRelOrcamentos.ShowReport;
end;

procedure TrelorcamentosF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DataModuleF.qryOrcamento.close;
  CloseAction := caFree;
end;

end.

