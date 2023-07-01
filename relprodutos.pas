unit relprodutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet, DataModule;

type

  { TrelprodutosF }

  TrelprodutosF = class(TForm)
    btnRelProduto: TBitBtn;
    frDBrelProdutos: TfrDBDataSet;
    frRelProdutos: TfrReport;
    procedure btnRelProdutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  relprodutosF: TrelprodutosF;

implementation

{$R *.lfm}

{ TrelprodutosF }

procedure TrelprodutosF.btnRelProdutoClick(Sender: TObject);
begin
  DataModuleF.qryProduto.open;
  frRelProdutos.LoadFromFile('RelProdutos.lrf');
  frRelProdutos.PrepareReport;
  frRelProdutos.ShowReport;
end;

procedure TrelprodutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DataModuleF.qryProduto.close;
  CloseAction := caFree;
end;

end.

