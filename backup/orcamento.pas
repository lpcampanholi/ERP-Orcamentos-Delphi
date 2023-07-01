unit Orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, DBExtCtrls, Buttons, DBGrids, LR_DBSet, LR_Class, Modelo, DB,
  DataModule, ClienteSelecionar, InserirItem;

type

  { TOrcamentoF }

  TOrcamentoF = class(TModeloF)
    btnAdicionarItem: TBitBtn;
    btnExcluirItem: TBitBtn;
    btnImprimir: TBitBtn;
    dbDateValidade: TDBDateEdit;
    dbedtNomeCliente: TDBEdit;
    dbedTotal: TDBEdit;
    dsOrcamentoItem: TDataSource;
    dsOrcamento: TDataSource;
    dbDateOrcamento: TDBDateEdit;
    dbedtIDOrcamento: TDBEdit;
    dbedtIDCliente: TDBEdit;
    DBGrid2: TDBGrid;
    frdbOrcamentoItem: TfrDBDataSet;
    frRelOrcamentoItem: TfrReport;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton1: TSpeedButton;
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  OrcamentoF: TOrcamentoF;

implementation

{$R *.lfm}

{ TOrcamentoF }

procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DataModuleF.qryOrcamento.Close;
  DataModuleF.qryOrcamentoItem.Close;
  inherited;
end;

procedure TOrcamentoF.btnAdicionarItemClick(Sender: TObject);
var
id : String;
begin
    DataModuleF.qryOrcamentoItem.Insert;

    //Busca o ultimo código do orçamento atual
    DataModuleF.qryGenerica.close;
    DataModuleF.qryGenerica.SQL.Clear;
    DataModuleF.qryGenerica.SQL.Add('SELECT MAX(orcamentoitemid) + 1 PROXCODIGO '+
                                    'FROM orcamento_item' +
                                    ' WHERE ORCAMENTOID = ' + IntToStr(DataModuleF.qryOrcamentoorcamentoid.AsInteger));
    DataModuleF.qryGenerica.Open;
    id := DataModuleF.qryGenerica.FieldByName('PROXCODIGO').AsString;
    if id = '' then
       DataModuleF.qryOrcamentoItemorcamentoitemid.AsInteger := 1
    else
       DataModuleF.qryOrcamentoItemorcamentoitemid.AsInteger := StrToInt(id);

    //Passando o código do orçamentoid
    DataModuleF.qryOrcamentoItemorcamentoid.AsInteger := DataModuleF.qryOrcamentoorcamentoid.AsInteger;

    //abre a tela de que permita fazer a busca do produto
    InserirItemF:= TInserirItemF.create(Self);
    InserirItemF.ShowModal;
end;

procedure TOrcamentoF.btnExcluirClick(Sender: TObject);
begin
  if  MessageDlg('Você tem certeza que deseja excluir este Orçamento?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    dsOrcamento.DataSet.Delete;
  end;
end;

procedure TOrcamentoF.btnExcluirItemClick(Sender: TObject);
begin
  dsOrcamentoItem.DataSet.Delete;
  DataModuleF.SomaItens;
end;

procedure TOrcamentoF.btnImprimirClick(Sender: TObject);
begin
  frRelOrcamentoItem.LoadFromFile('RelOrcamentoItem.lrf');
  frRelOrcamentoItem.PrepareReport;
  frRelOrcamentoItem.ShowReport;
end;

procedure TOrcamentoF.btnNovoClick(Sender: TObject);
begin
  inherited;
  if DataModuleF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DataModuleF.qryOrcamento.Post;
    DataModuleF.qryOrcamento.Insert;
    DataModuleF.AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
  end
  else
  begin
    DataModuleF.qryOrcamento.Insert;
    DataModuleF.qryOrcamentoItem.Insert;
    DataModuleF.AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
  end;
  dbedtIDOrcamento.SetFocus;
end;

procedure TOrcamentoF.btnPesquisaClick(Sender: TObject);
var
  AuxWhere : String;
begin
  if edtPesq.Text = '' then
    AuxWhere := '1 = 1'
  else
    AuxWhere := 'cast(orcamentoid as varchar(10)) = '+QuotedStr(edtPesq.Text);
  DataModuleF.qryOrcamento.Close;
  DataModuleF.qryOrcamento.SQL.Text :=
              'SELECT '+
              'ORCAMENTO.ORCAMENTOID, '+
              'ORCAMENTO.CLIENTEID, '+
              'ORCAMENTO.DT_ORCAMENTO, '+
              'ORCAMENTO.DT_VALIDADE_ORCAMENTO, '+
              'ORCAMENTO.VL_TOTAL_ORCAMENTO, '+
              'CLIENTE.NOME_CLIENTE '+
              'FROM ORCAMENTO '+
              'LEFT JOIN CLIENTE ON ORCAMENTO.CLIENTEID = CLIENTE.CLIENTEID '+
              'WHERE '+ AuxWhere +' '+
              'ORDER BY ORCAMENTO.ORCAMENTOID';
  DataModuleF.qryOrcamento.Open;
end;

procedure TOrcamentoF.btnSalvarClick(Sender: TObject);
begin
  DataModuleF.SomaItens;
  if DataModuleF.qryOrcamento.State in [dsInsert, dsEdit] then
  begin
    DataModuleF.qryOrcamento.post;
  end;
  PageControl1.TabIndex := 0;
end;

procedure TOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
  DataModuleF.AbreOrcItens(DataModuleF.qryOrcamentoorcamentoid.AsInteger);
end;

procedure TOrcamentoF.FormShow(Sender: TObject);
begin
  dsOrcamento.DataSet.Open;
  inherited;
end;

procedure TOrcamentoF.SpeedButton1Click(Sender: TObject);
begin
  DataModuleF.qryOrcamento.edit;
  ClienteSelecionarF := TClienteSelecionarF.Create(Self);
  ClienteSelecionarF.showmodal;
end;

end.

