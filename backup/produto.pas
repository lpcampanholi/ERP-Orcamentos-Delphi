unit Produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBExtCtrls, Buttons, Modelo, odbcconn, DB, DataModule, CategoriaSelecionar, ComCtrls,
  LCLExceptionStackTrace, ZSysUtils;

type

  { TProdutoF }

  TProdutoF = class(TModeloF)
    dbcbStatus: TDBComboBox;
    dbDate: TDBDateEdit;
    dbedtDsCategoria: TDBEdit;
    dbedtDsProduto: TDBEdit;
    dbedtObsProduto: TDBEdit;
    dbedtValorVenda: TDBEdit;
    dbedtCategoria: TDBEdit;
    dbedtID: TDBEdit;
    dsProduto: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    spbtnCategoria: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure spbtnCategoriaClick(Sender: TObject);

  private
    procedure HabilitaCampos;
    procedure DesabilitaCampos;
  public

  end;

var
  ProdutoF: TProdutoF;
  ModoEdicao: Boolean;

implementation

{$R *.lfm}

{ TProdutoF }

procedure HabilitaCampos;
begin
  ProdutoF.dbedtID.Enabled := True;
  ProdutoF.dbDate.Enabled := True;
  ProdutoF.dbcbStatus.Enabled := True;
  ProdutoF.dbedtCategoria.Enabled := True;
  ProdutoF.dbedtDsProduto.Enabled := True;
  ProdutoF.dbedtObsProduto.Enabled := True;
  ProdutoF.dbedtValorVenda.Enabled := True;
  ProdutoF.spbtnCategoria.Enabled := True;
  ProdutoF.dbedtDsCategoria.Enabled := True;
end;

procedure DesabilitaCampos;
begin
  ProdutoF.dbedtID.Enabled := False;
  ProdutoF.dbDate.Enabled := False;
  ProdutoF.dbcbStatus.Enabled := False;
  ProdutoF.dbedtCategoria.Enabled := False;
  ProdutoF.dbedtDsProduto.Enabled := False;
  ProdutoF.dbedtObsProduto.Enabled := False;
  ProdutoF.dbedtValorVenda.Enabled := False;
  ProdutoF.spbtnCategoria.Enabled := False;
  ProdutoF.dbedtDsCategoria.Enabled := False;
end;

procedure TProdutoF.FormShow(Sender: TObject);
begin
  ModoEdicao := False;
  btnSalvar.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  inherited;
end;

procedure TProdutoF.PageControl1Change(Sender: TObject);
begin
  {if ModoEdicao then
  begin
    ShowMessage('É necessário usar os botões "Salvar" ou "Cancelar" para sair deste formulário.');
    abort;
  end;}
  DesabilitaCampos;
  DataModuleF.qryProduto.Cancel;
end;

procedure TProdutoF.spbtnCategoriaClick(Sender: TObject);
begin
  CategoriaSelecionarF := TCategoriaSelecionarF.Create(Self);
  CategoriaSelecionarF.showmodal;
end;

procedure TProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
  DesabilitaCampos;
  dbcbStatus.Color := $00F1F1F1;
  btnExcluir.Enabled := True;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
end;

procedure TProdutoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryProduto.Open;
  DataModuleF.qryProduto.Insert;
  HabilitaCampos;
  btnSalvar.Enabled := True;
  btnExcluir.Enabled := False;
  btnEditar.Enabled := False;
  DataModuleF.qryProdutodt_cadastro_produto.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  dbcbStatus.ItemIndex := 0;
  dbedtID.setfocus;
end;

procedure TProdutoF.btnPesquisaClick(Sender: TObject);
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
                                     'WHERE PRODUTOID = '+ edtPesq.Text+
                                     'ORDER BY PRODUTO.DS_PRODUTO';
  end;
  DataModuleF.qryProduto.Open;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
end;

procedure TProdutoF.btnSalvarClick(Sender: TObject);
begin
  if DataModuleF.qryProduto.State in [dsEdit, dsInsert] then
  begin
    DataModuleF.qryProduto.Post;
    DataModuleF.qryProduto.ApplyUpdates;
  end;
  DesabilitaCampos;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
  btnExcluir.Enabled := True;
end;

procedure TProdutoF.btnEditarClick(Sender: TObject);
begin
  HabilitaCampos;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  ModoEdicao := True;
  dbedtID.setfocus;
  DataModuleF.qryProduto.Edit;
end;

procedure TProdutoF.btnCancelarClick(Sender: TObject);
begin
  DataModuleF.qryProduto.Cancel;
  ModoEdicao := False;
  inherited;
end;

procedure TProdutoF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryProduto.Delete;
  end;
end;

procedure TProdutoF.btnFecharClick(Sender: TObject);
begin
  DataModuleF.qryProduto.Close;
  inherited;
end;

end.

