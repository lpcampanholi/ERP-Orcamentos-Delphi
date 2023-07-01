unit Categoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  Modelo, DB, DataModule;

type

  { TCategoriaF }

  TCategoriaF = class(TModeloF)
    dbedtID: TDBEdit;
    dbedtDsCategoria: TDBEdit;
    dsCategoria: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
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
  CategoriaF: TCategoriaF;
  ModoEdicao: boolean;

implementation

{$R *.lfm}

{ TCategoriaF }

procedure TCategoriaF.FormShow(Sender: TObject);
begin
  ModoEdicao := False;
  btnSalvar.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  inherited;
end;

procedure TCategoriaF.PageControl1Change(Sender: TObject);
begin
  dbedtID.Enabled := False;
  dbedtDsCategoria.Enabled := False;
  btnSalvar.Enabled := False;
end;

procedure TCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
  dbedtID.Enabled := False;
  dbedtDsCategoria.Enabled := False;
  btnExcluir.Enabled := True;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
end;

procedure TCategoriaF.btnNovoClick(Sender: TObject);
begin
  inherited;
  DataModuleF.qryCategoria.Open;
  DataModuleF.qryCategoria.Insert;
  btnSalvar.Enabled := True;
  dbedtID.Enabled := True;
  dbedtDsCategoria.Enabled := True;
  btnSalvar.Enabled := True;
  btnExcluir.Enabled := False;
  btnEditar.Enabled := False;
  dbedtDsCategoria.setfocus;
  ModoEdicao := True;
end;

procedure TCategoriaF.btnPesquisaClick(Sender: TObject);
begin
  DataModuleF.qryCategoria.Close;
  if edtPesq.Text = '' then
  begin
    DataModuleF.qryCategoria.SQL.Text := 'SELECT '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_CATEGORIA_PRODUTO '+
                                         'FROM CATEGORIA_PRODUTO '+
                                         'ORDER BY DS_CATEGORIA_PRODUTO';
  end
  else
  begin
    DataModuleF.qryCategoria.SQL.Text := 'SELECT '+
                                         'CATEGORIAPRODUTOID, '+
                                         'DS_CATEGORIA_PRODUTO '+
                                         'FROM CATEGORIA_PRODUTO '+
                                         'WHERE DS_CATEGORIA_PRODUTO LIKE ' +  QuotedStr('%'+edtPesq.Text+'%') +
                                         'ORDER BY DS_CATEGORIA_PRODUTO';
  end;
  DataModuleF.qryCategoria.Open;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
end;


procedure TCategoriaF.btnSalvarClick(Sender: TObject);
begin
  if DataModuleF.qryCategoria.State in [dsEdit, dsInsert] then
  begin
    DataModuleF.qryCategoria.Post;
    DataModuleF.qryCategoria.ApplyUpdates;
  end;
  dbedtID.Enabled := False;
  dbedtDsCategoria.Enabled := False;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
  btnExcluir.Enabled := True;
  ModoEdicao := False;
end;

procedure TCategoriaF.btnCancelarClick(Sender: TObject);
begin
  ModoEdicao := False;
  inherited;
end;

procedure TCategoriaF.btnEditarClick(Sender: TObject);
begin
  dbedtID.Enabled := True;
  dbedtDsCategoria.Enabled := True;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  ModoEdicao := True;
  dbedtID.setfocus;
  DataModuleF.qryCategoria.Edit;
end;

procedure TCategoriaF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryCategoria.Delete;
  end;
end;

procedure TCategoriaF.btnFecharClick(Sender: TObject);
begin
  DataModuleF.qryCategoria.Close;
  inherited;
end;

end.

