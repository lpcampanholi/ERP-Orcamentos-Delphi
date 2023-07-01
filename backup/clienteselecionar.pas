unit ClienteSelecionar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBGrids, DataModule;

type

  { TClienteSelecionarF }

  TClienteSelecionarF = class(TForm)
    btnFechar: TBitBtn;
    btnPesquisa: TBitBtn;
    DBGrid1: TDBGrid;
    dsCliente: TDataSource;
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
  ClienteSelecionarF: TClienteSelecionarF;

implementation

{$R *.lfm}

{ TClienteSelecionarF }

procedure TClienteSelecionarF.btnPesquisaClick(Sender: TObject);
begin
  DataModuleF.qryCliente.Close;
  if edtPesq.Text = '' then
  begin
    DataModuleF.qryCliente.SQL.Text := 'SELECT ' +
                                       'CLIENTEID, '+
                                       'NOME_CLIENTE, '+
                                       'TIPO_CLIENTE, '+
                                       'CPF_CNPJ_CLIENTE '+
                                       'FROM CLIENTE '+
                                       'ORDER BY NOME_CLIENTE';
  end
  else
  begin
     DataModuleF.qryCliente.SQL.Text := 'SELECT ' +
                                        'CLIENTEID, '+
                                        'NOME_CLIENTE, '+
                                        'TIPO_CLIENTE, '+
                                        'CPF_CNPJ_CLIENTE '+
                                        'FROM CLIENTE '+
                                        'WHERE NOME_CLIENTE LIKE ' +  QuotedStr('%'+edtPesq.Text+'%') +
                                        'ORDER BY NOME_CLIENTE';
  end;
  DataModuleF.qryCliente.Open;
end;

procedure TClienteSelecionarF.DBGrid1DblClick(Sender: TObject);
begin
  DataModuleF.qryOrcamentoclienteid.AsInteger := DataModuleF.qryClienteclienteid.AsInteger;
  DataModulef.qryOrcamentonome_cliente.AsString := DataModuleF.qryClientenome_cliente.AsString;
  Close;
end;


procedure TClienteSelecionarF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DataModuleF.qryCliente.Close;
  CloseAction := caFree;
end;

procedure TClienteSelecionarF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TClienteSelecionarF.FormShow(Sender: TObject);
begin
  //DataModuleF.qryCliente.open;
end;

end.

