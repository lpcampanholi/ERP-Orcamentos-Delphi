unit CategoriaSelecionar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  DBGrids, StdCtrls, LR_Class, DataModule;

type

  { TCategoriaSelecionarF }

  TCategoriaSelecionarF = class(TForm)
    btnFechar: TBitBtn;
    btnPesquisa: TBitBtn;
    DBGrid1: TDBGrid;
    dsCategoria: TDataSource;
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
  CategoriaSelecionarF: TCategoriaSelecionarF;

implementation

{$R *.lfm}

uses
  Produto;

{ TCategoriaSelecionarF }

procedure TCategoriaSelecionarF.DBGrid1DblClick(Sender: TObject);
begin
  DataModuleF.qryProdutocategoriaprodutoid.AsInteger := DataModuleF.qryCategoriacategoriaprodutoid.AsInteger;
  DataModuleF.qryProdutods_categoria_produto.AsString := DataModuleF.qryCategoriads_categoria_produto.AsString;
  Close;
end;

procedure TCategoriaSelecionarF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DataModuleF.qryCategoria.Close;
  CloseAction := caFree;
end;

procedure TCategoriaSelecionarF.FormShow(Sender: TObject);
begin
  //DataModuleF.qryCategoria.open;
end;

procedure TCategoriaSelecionarF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TCategoriaSelecionarF.btnPesquisaClick(Sender: TObject);
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
end;

end.

