unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZSqlUpdate;

type

  { TDataModuleF }

  TDataModuleF = class(TDataModule)
    qryCategoriacategoriaprodutoid: TLongintField;
    qryCategoriads_categoria_produto: TStringField;
    qryClienteclienteid: TLongintField;
    qryClientecpf_cnpj_cliente: TStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TStringField;
    qryOrcamentoclienteid: TLongintField;
    qryOrcamentodt_orcamento: TDateTimeField;
    qryOrcamentodt_validade_orcamento: TDateTimeField;
    qryOrcamentoItemorcamentoid: TLongintField;
    qryOrcamentoItemorcamentoitemid: TLongintField;
    qryOrcamentoItemprodutodesc: TStringField;
    qryOrcamentoItemprodutoid: TLongintField;
    qryOrcamentoItemqt_produto: TFloatField;
    qryOrcamentoItemvl_total: TFloatField;
    qryOrcamentoItemvl_unitario: TFloatField;
    qryOrcamentonome_cliente: TStringField;
    qryOrcamentoorcamentoid: TLongintField;
    qryOrcamentovl_total_orcamento: TFloatField;
    qryProdutocategoriaprodutoid: TLongintField;
    qryProdutods_categoria_produto: TStringField;
    qryProdutods_produto: TStringField;
    qryProdutodt_cadastro_produto: TDateTimeField;
    qryProdutoobs_produto: TStringField;
    qryProdutoprodutoid: TLongintField;
    qryProdutostatus_produto: TStringField;
    qryProdutovl_venda_produto: TFloatField;
    qryUsuarioid: TLongintField;
    qryUsuarionome_completo: TStringField;
    qryUsuariosenha: TStringField;
    qryUsuariousuario: TStringField;
    ZConnection: TZConnection;
    qryProduto: TZQuery;
    qryCategoria: TZQuery;
    updtCategoria: TZUpdateSQL;
    qryGenerica: TZQuery;
    updtProduto: TZUpdateSQL;
    qryCliente: TZQuery;
    updtCliente: TZUpdateSQL;
    qryOrcamentoItem: TZQuery;
    updtOrcamentoItem: TZUpdateSQL;
    qryOrcamento: TZQuery;
    updtOrcamento: TZUpdateSQL;
    qryUsuario: TZQuery;
    updtUsuario: TZUpdateSQL;
    procedure qryCategoriaNewRecord(DataSet: TDataSet);
    procedure qryClienteNewRecord(DataSet: TDataSet);
    procedure qryOrcamentoAfterOpen(DataSet: TDataSet);
    procedure qryOrcamentoAfterPost(DataSet: TDataSet);
    procedure qryOrcamentoNewRecord(DataSet: TDataSet);
    procedure qryProdutoNewRecord(DataSet: TDataSet);
    procedure qryOrcamentoItemqt_produtoChange(Sender: TField);
    procedure qryUsuarioNewRecord(DataSet: TDataSet);
  private

  public
    function getSequence(const pNomeSequence: String): String;
    procedure AbreOrcItens(orcamentoid : Integer);
    procedure SomaItens;
  end;

var
  DataModuleF: TDataModuleF;

implementation

{$R *.lfm}

procedure TDataModuleF.qryOrcamentoItemqt_produtoChange(Sender: TField);
var  xQtde, xVlrUnit, xVlrTotal : double;
begin
  xQtde     := qryOrcamentoItemqt_produto.AsFloat;
  xVlrUnit  := qryOrcamentoItemvl_unitario.AsFloat;

  if  xQtde > 0  then
      qryOrcamentoItemvl_total.AsFloat := xQtde * xVlrUnit;

end;

procedure TDataModuleF.qryUsuarioNewRecord(DataSet: TDataSet);
begin
  qryUsuarioid.AsInteger := StrToInt(getSequence('usuario_id_seq'));
end;

procedure TDataModuleF.SomaItens;
begin
  if not (DataModuleF.qryOrcamento.State in [dsEdit, dsInsert]) then
     DataModuleF.qryOrcamento.Edit;

  if not (DataModuleF.qryOrcamentoItem.State in [dsEdit, dsInsert]) then
     DataModuleF.qryOrcamentoItem.Edit;

  //Vai pro Primeiro
  DataModuleF.qryOrcamentoItem.First;
  DataModuleF.qryOrcamentovl_total_orcamento.AsFloat := 0;
  while not DataModuleF.qryOrcamentoItem.Eof do
  begin
    DataModuleF.qryOrcamentovl_total_orcamento.AsFloat := DataModuleF.qryOrcamentovl_total_orcamento.AsFloat + DataModuleF.qryOrcamentoItemvl_total.AsFloat;
  end;
end;

procedure TDataModuleF.qryCategoriaNewRecord(DataSet: TDataSet);
begin
  qryCategoriacategoriaprodutoid.AsInteger := StrToInt(getSequence('categoria_produto_categoriaprodutoid_seq'));
end;

procedure TDataModuleF.qryClienteNewRecord(DataSet: TDataSet);
begin
  qryClienteclienteid.AsInteger := StrToInt(getSequence('cliente_clienteid'));
end;

procedure TDataModuleF.qryOrcamentoAfterOpen(DataSet: TDataSet);
begin
  AbreOrcItens(qryOrcamentoorcamentoid.AsInteger);
end;

procedure TDataModuleF.qryOrcamentoAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;

procedure TDataModuleF.qryOrcamentoNewRecord(DataSet: TDataSet);
begin
  qryOrcamentoorcamentoid.AsInteger := StrToInt(getSequence('orcamento_orcamentoid_seq'));
  qryOrcamentodt_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  qryOrcamentodt_validade_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now + 15));
end;

procedure TDataModuleF.qryProdutoNewRecord(DataSet: TDataSet);
begin
  qryProdutoprodutoid.AsInteger := StrToInt(getSequence('produto_produtoid'));
end;

function TDataModuleF.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;
 finally
   qryGenerica.Close;
 end;
end;

procedure TDataModuleF.AbreOrcItens(orcamentoid : Integer);
begin
  if orcamentoid <> 0 then
  begin
      qryOrcamentoItem.Close;
      qryOrcamentoItem.SQL.Clear;
      qryOrcamentoItem.SQL.Add(
                      'SELECT '+
                      'ORCAMENTOITEMID, '+
                      'ORCAMENTOID, '+
                      'PRODUTOID, '+
                      'produtodesc, '+
                      'QT_PRODUTO, '+
                      'VL_UNITARIO, '+
                      'VL_TOTAL '+
                      'FROM ORCAMENTO_ITEM ' +
                      'WHERE ORCAMENTOID = '+ inttostr(orcamentoid) + ' ' +
                      'ORDER BY ORCAMENTOID');
       qryOrcamentoItem.Open;
  end;
end;

end.

