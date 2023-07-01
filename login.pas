unit Login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menu, DataModule;

type

  { TLoginF }

  TLoginF = class(TForm)
    brnEntrar: TButton;
    btnSair: TButton;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    Image1: TImage;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure brnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  LoginF: TLoginF;

implementation

{$R *.lfm}

{ TLoginF }

procedure TLoginF.FormShow(Sender: TObject);
begin
  edtUsuario.SetFocus;
end;

procedure TLoginF.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLoginF.brnEntrarClick(Sender: TObject);
var
  SenhaDigitada, SenhaArmazenada: string;
  UsuarioDigitado, UsuarioArmazenado: string;
begin
  DataModuleF.qryUsuario.Open;
  SenhaDigitada := edtSenha.Text;
  SenhaArmazenada := DataModuleF.qryUsuario.FieldByName('SENHA').AsString;

  UsuarioDigitado :=  edtUsuario.Text;
  UsuarioArmazenado := DataModuleF.qryUsuario.FieldByName('USUARIO').AsString;

  if (SenhaDigitada = SenhaArmazenada) AND (UsuarioDigitado = UsuarioArmazenado) then
   begin
    MenuF := TMenuF.Create(Self);
    MenuF.ShowModal;
    Close;
   end
  else
   begin
     ShowMessage('Por favor, tente novamente.');
     edtSenha.Clear;
     edtSenha.SetFocus;
   end;
  DataModuleF.qryUsuario.Close;
end;

end.

