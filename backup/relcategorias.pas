unit relcategorias;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class;

type

  { TrelcategoriasF }

  TrelcategoriasF = class(TForm)
    btnRelCategoria: TBitBtn;
    frDBrelCategorias: TfrDBDataSet;
    frRelCategorias: TfrReport;
    procedure btnRelCategoriaClick(Sender: TObject);
  private

  public

  end;

var
  relcategoriasF: TrelcategoriasF;

implementation

{$R *.lfm}

{ TrelcategoriasF }

procedure TrelcategoriasF.btnRelCategoriaClick(Sender: TObject);
begin
  //frRelCategorias.LoadFromFile('RelProdutos.lrf');
  //frRelCategorias.PrepareReport;
  //frRelCategorias.ShowReport;
end;

end.

