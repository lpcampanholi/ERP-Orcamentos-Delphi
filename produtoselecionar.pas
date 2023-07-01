unit ProdutoSelecionar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, DataModule;

type

  { TProdutoSelecionarF }

  TProdutoSelecionarF = class(TForm)
    btnFechar: TBitBtn;
    btnPesquisa: TBitBtn;
    DBGrid1: TDBGrid;
    dsProduto: TDataSource;
    edtPesq: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  ProdutoSelecionarF: TProdutoSelecionarF;

implementation

{$R *.lfm}

uses
  InserirItem;

{ TProdutoSelecionarF }

procedure TProdutoSelecionarF.btnPesquisaClick(Sender: TObject);
begin
  DataModuleF.qryProduto.Close;
  if edtPesq.Text = '' then
  begin
    DataModuleF.qryProduto.SQL.Text := 'SELECT ' +
                                     'PRODUTO.PRODUTOID, '+
                                     'PRODUTO.CATEGORIAPRODUTOID, '+
                                     'PRODUTO.DS_PRODUTO, '+
                                     'PRODUTO.OBS_PRODUTO, '+
                                     'PRODUTO.VL_VENDA_PRODUTO, '+
                                     'PRODUTO.DT_CADASTRO_PRODUTO, '+
                                     'PRODUTO.STATUS_PRODUTO, '+
                                     'CATEGORIA_PRODUTO.DS_CATEGORIA_PRODUTO '+
                                     'FROM PRODUTO '+
                                     'LEFT JOIN CATEGORIA_PRODUTO ON PRODUTO.CATEGORIAPRODUTOID = CATEGORIA_PRODUTO.CATEGORIAPRODUTOID '+
                                     'ORDER BY PRODUTO.DS_PRODUTO';
  end
  else
  begin
     DataModuleF.qryProduto.SQL.Text := 'SELECT ' +
                                     'PRODUTO.PRODUTOID, '+
                                     'PRODUTO.CATEGORIAPRODUTOID, '+
                                     'PRODUTO.DS_PRODUTO, '+
                                     'PRODUTO.OBS_PRODUTO, '+
                                     'PRODUTO.VL_VENDA_PRODUTO, '+
                                     'PRODUTO.DT_CADASTRO_PRODUTO, '+
                                     'STATUS_PRODUTO, '+
                                     'CATEGORIA_PRODUTO.DS_CATEGORIA_PRODUTO '+
                                     'FROM PRODUTO '+
                                     'LEFT JOIN CATEGORIA_PRODUTO ON PRODUTO.CATEGORIAPRODUTOID = CATEGORIA_PRODUTO.CATEGORIAPRODUTOID '+
                                     'WHERE PRODUTOID = '+edtPesq.Text+
                                     'ORDER BY PRODUTO.DS_PRODUTO';
  end;
  DataModuleF.qryProduto.Open;
end;

procedure TProdutoSelecionarF.DBGrid1DblClick(Sender: TObject);
begin
  DataModuleF.qryOrcamentoItemprodutoid.AsInteger := DataModuleF.qryProdutoprodutoid.AsInteger;
  DataModuleF.qryOrcamentoItemprodutodesc.AsString := DataModuleF.qryProdutods_produto.AsString;
  DataModuleF.qryOrcamentoItemvl_unitario.AsFloat := DataModuleF.qryProdutovl_venda_produto.AsFloat;
  Close;
  InserirItemF.dbedtQtde.SetFocus;
end;

procedure TProdutoSelecionarF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DataModuleF.qryProduto.Close;
  CloseAction := caFree;
end;

procedure TProdutoSelecionarF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TProdutoSelecionarF.FormShow(Sender: TObject);
begin
  //DataModuleF.qryProduto.open;
end;

end.

