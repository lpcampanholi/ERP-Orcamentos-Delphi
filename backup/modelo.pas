unit Modelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, StdCtrls, Grids, DBGrids, Menus, RTTIGrids;

type

  { TModeloF }

  TModeloF = class(TForm)
    btnPesquisa: TBitBtn;
    btnNovo: TBitBtn;
    btnFechar: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    DBGrid1: TDBGrid;
    edtPesq: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  ModeloF: TModeloF;

implementation

{$R *.lfm}

{ TModeloF }

procedure TModeloF.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
end;

procedure TModeloF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TModeloF.btnCancelarClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 0;
end;

procedure TModeloF.btnNovoClick(Sender: TObject);
begin
  PageControl1.TabIndex:= 1;
end;

procedure TModeloF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

