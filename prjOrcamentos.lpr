program prjOrcamentos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, zcomponent, Modelo, Menu, DataModule,
  Categoria, Produto, CategoriaSelecionar, Cliente, Orcamento,
  ClienteSelecionar, ProdutoSelecionar, InserirItem, relclientes, relprodutos,
  relcategorias, sobre, Login, Usuario, relorcamentos
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TLoginF, LoginF);
  Application.CreateForm(TDataModuleF, DataModuleF);
  Application.Run;
end.

