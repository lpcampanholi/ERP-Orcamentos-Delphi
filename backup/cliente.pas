unit Cliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  Modelo, DB, DataModule;

type

  { TClienteF }

  TClienteF = class(TModeloF)
    dbedtNomeCliente: TDBEdit;
    dbedtID: TDBEdit;
    dbedtCpfCnpjCliente: TDBEdit;
    dbgroupTipoCliente: TDBRadioGroup;
    dsCliente: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
  private

  public

  end;

var
  ClienteF: TClienteF;
  ModoEdicao: Boolean;

implementation

{$R *.lfm}

{ TClienteF }

procedure TClienteF.FormShow(Sender: TObject);
begin
  ModoEdicao := False;
  btnSalvar.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  inherited;
end;

procedure TClienteF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
  dbedtID.Enabled := False;
  dbgroupTipoCliente.Enabled := False;
  dbedtNomeCliente.Enabled := False;
  dbedtCpfCnpjCliente.Enabled := False;
  btnExcluir.Enabled := True;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
end;

procedure TClienteF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryCliente.Open;
  DataModuleF.qryCliente.Insert;
  dbedtID.Enabled := True;
  dbgroupTipoCliente.Enabled := True;
  dbedtNomeCliente.Enabled := True;
  dbedtCpfCnpjCliente.Enabled := True;
  btnSalvar.Enabled := True;
  btnExcluir.Enabled := False;
  btnEditar.Enabled := False;
  dbedtID.setfocus;
  ModoEdicao := True;
end;

procedure TClienteF.btnEditarClick(Sender: TObject);
begin
  dbedtID.Enabled := True;
  dbgroupTipoCliente.Enabled := True;
  dbedtNomeCliente.Enabled := True;
  dbedtCpfCnpjCliente.Enabled := True;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  ModoEdicao := True;
  dbedtID.setfocus;
  DataModuleF.qryCliente.Edit;
end;

procedure TClienteF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryCliente.Delete;
  end;
end;

procedure TClienteF.btnFecharClick(Sender: TObject);
begin
  DataModuleF.qryCliente.Close;
  inherited;
end;

procedure TClienteF.btnCancelarClick(Sender: TObject);
begin
  DataModuleF.qryCliente.Cancel;
  ModoEdicao := False;
  inherited;
end;

procedure TClienteF.btnPesquisaClick(Sender: TObject);
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
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
end;

procedure TClienteF.btnSalvarClick(Sender: TObject);
begin
  if DataModuleF.qryCliente.State in [dsEdit, dsInsert] then
  begin
    DataModuleF.qryCliente.Post;
    DataModuleF.qryCliente.ApplyUpdates;
  end;
  dbedtID.Enabled := False;
  dbgroupTipoCliente.Enabled := False;
  dbedtNomeCliente.Enabled := False;
  dbedtCpfCnpjCliente.Enabled := False;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
  btnExcluir.Enabled := True;
  ModoEdicao := False;
end;

procedure TClienteF.PageControl1Change(Sender: TObject);
begin
  if ModoEdicao then
  begin
    ShowMessage('É necessário usar os botões "Salvar" ou "Cancelar" para sair deste formulário.');
    abort;
  end;
  dbedtID.Enabled := False;
  dbgroupTipoCliente.Enabled := False;
  dbedtNomeCliente.Enabled := False;
  dbedtCpfCnpjCliente.Enabled := False;
  btnSalvar.Enabled := False;
end;

end.

