unit Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  Modelo, DataModule;

type

  { TUsuarioF }

  TUsuarioF = class(TModeloF)
    dbedtUsuario: TDBEdit;
    dbedtNomeCompleto: TDBEdit;
    dbedtID: TDBEdit;
    dbedtSenha: TDBEdit;
    dsUsuario: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private

  public

  end;

var
  UsuarioF: TUsuarioF;

implementation

{$R *.lfm}

{ TUsuarioF }

procedure TUsuarioF.FormShow(Sender: TObject);
begin
  DataModuleF.qryUsuario.Open;
  btnSalvar.Enabled := False;
  inherited;
end;

procedure TUsuarioF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
  dbedtID.Enabled := False;
  dbedtUsuario.Enabled := False;
  dbedtNomeCompleto.Enabled := False;
  dbedtSenha.Enabled := False;
  btnSalvar.Enabled := False;
  btnExcluir.Enabled := True;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
end;

procedure TUsuarioF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DataModuleF.qryUsuario.Close;
  inherited;
end;

procedure TUsuarioF.btnNovoClick(Sender: TObject);
begin
  DataModuleF.qryUsuario.Open;
  DataModuleF.qryUsuario.Insert;
  dbedtID.Enabled := True;
  dbedtUsuario.Enabled := True;
  dbedtNomeCompleto.Enabled := True;
  dbedtSenha.Enabled := True;
  btnSalvar.Enabled := False;
  btnSalvar.Enabled := True;
  btnExcluir.Enabled := False;
  btnEditar.Enabled := False;
  inherited;
  dbedtID.setfocus;
end;

procedure TUsuarioF.btnEditarClick(Sender: TObject);
begin
  dbedtID.Enabled := True;
  dbedtUsuario.Enabled := True;
  dbedtNomeCompleto.Enabled := True;
  dbedtSenha.Enabled := True;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  dbedtID.setfocus;
  DataModuleF.qryUsuario.Edit;
end;

procedure TUsuarioF.btnExcluirClick(Sender: TObject);
begin
  If  MessageDlg('Você tem certeza que deseja excluir este Usuário?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    DataModuleF.qryUsuario.Delete;
  end;
end;

procedure TUsuarioF.btnFecharClick(Sender: TObject);
begin
  inherited;
end;

procedure TUsuarioF.btnCancelarClick(Sender: TObject);
begin
  DataModuleF.qryUsuario.Cancel;
  inherited;
end;

procedure TUsuarioF.btnSalvarClick(Sender: TObject);
begin
  if DataModuleF.qryUsuario.State in [dsEdit, dsInsert] then
  begin
    DataModuleF.qryUsuario.Post;
    DataModuleF.qryUsuario.ApplyUpdates;
  end;
  dbedtID.Enabled := False;
  dbedtUsuario.Enabled := False;
  dbedtNomeCompleto.Enabled := False;
  dbedtSenha.Enabled := False;
  btnEditar.Enabled := True;
  btnSalvar.Enabled := False;
  btnExcluir.Enabled := True;
end;

procedure TUsuarioF.PageControl1Change(Sender: TObject);
begin
  dbedtID.Enabled := False;
  dbedtUsuario.Enabled := False;
  dbedtNomeCompleto.Enabled := False;
  dbedtSenha.Enabled := False;
  btnSalvar.Enabled := False;
  DataModuleF.qryUsuario.Cancel;
end;

end.

