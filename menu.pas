unit Menu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, Categoria, Produto, Cliente, Orcamento, Sobre, relclientes,
  relprodutos, relorcamentos, Usuario;

type

  { TMenuF }

  TMenuF = class(TForm)
    Image1: TImage;
    Label10: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  MenuF: TMenuF;

implementation

{$R *.lfm}

{ TMenuF }

procedure TMenuF.MenuItem5Click(Sender: TObject);
begin
  Application.terminate;
end;

procedure TMenuF.MenuItem10Click(Sender: TObject);
begin
  OrcamentoF := TOrcamentoF.Create(Self);
  OrcamentoF.showmodal;
end;

procedure TMenuF.MenuItem11Click(Sender: TObject);
begin
  relclientesF := TrelclientesF.Create(Self);
  relclientesF.showmodal;
end;

procedure TMenuF.MenuItem12Click(Sender: TObject);
begin
  relprodutosF := TrelprodutosF.Create(Self);
  relprodutosF.showmodal;
end;

procedure TMenuF.MenuItem13Click(Sender: TObject);
begin
  relorcamentosF := TrelorcamentosF.Create(Self);
  relorcamentosF.showmodal;
end;

procedure TMenuF.MenuItem4Click(Sender: TObject);
begin
  SobreF := TSobreF.Create(Self);
  SobreF.showmodal;
end;

procedure TMenuF.MenuItem6Click(Sender: TObject);
begin
  CategoriaF := TCategoriaF.Create(Self);
  CategoriaF.showmodal;
end;

procedure TMenuF.MenuItem7Click(Sender: TObject);
begin
  ClienteF := TClienteF.Create(Self);
  ClienteF.showmodal;
end;

procedure TMenuF.MenuItem8Click(Sender: TObject);
begin
  ProdutoF := TProdutoF.Create(Self);
  ProdutoF.showmodal;
end;

procedure TMenuF.MenuItem9Click(Sender: TObject);
begin
  UsuarioF := TUsuarioF.Create(Self);
  UsuarioF.showmodal;
end;

end.

