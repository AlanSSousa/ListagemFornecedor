unit untFormularioImpressaoFR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ZAbstractConnection, ZConnection,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls,
  RLReport;

type
  TformularioImpressaoFR = class(TForm)
    btnVoltar: TButton;
    btnImprimir: TButton;
    Relatorio: TRLReport;
    RLMemo1: TRLMemo;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formularioImpressaoFR: TformularioImpressaoFR;

implementation

{$R *.dfm}

procedure TformularioImpressaoFR.btnImprimirClick(Sender: TObject);
begin
  Relatorio.Print;
end;

procedure TformularioImpressaoFR.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
  //Self.Visible := False;
end;

end.
