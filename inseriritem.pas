unit InserirItem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, ExtCtrls, ProdutoSelecionar, DataModule;

type

  { TInserirItemF }

  TInserirItemF = class(TForm)
    btnCancelar: TBitBtn;
    btnInserir: TBitBtn;
    dbedtIDProduto: TDBEdit;
    dbedtDsProduto: TDBEdit;
    dbedtVlrUnit: TDBEdit;
    dbedtVlrTotal: TDBEdit;
    dbedtQtde: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    spbtnCategoria: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure spbtnCategoriaClick(Sender: TObject);
  private

  public

  end;

var
  InserirItemF: TInserirItemF;

implementation

uses
  Orcamento;

{$R *.lfm}

{ TInserirItemF }

procedure TInserirItemF.spbtnCategoriaClick(Sender: TObject);
begin
  ProdutoSelecionarF := TProdutoSelecionarF.Create(Self);
  ProdutoSelecionarF.showmodal;
end;

procedure TInserirItemF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction := caFree;
end;

procedure TInserirItemF.btnCancelarClick(Sender: TObject);
begin
  OrcamentoF.dsOrcamentoItem.DataSet.Cancel;
  Close;
end;

procedure TInserirItemF.btnInserirClick(Sender: TObject);
begin
  if DataModuleF.qryOrcamentoItemqt_produto.AsFloat = 0 then
  begin
    ShowMessage('A quantidade deve ser preenchida!');
    dbedtQtde.SetFocus;
    Exit;
  end;
  DataModuleF.SomaItens;
  close;
end;

end.

