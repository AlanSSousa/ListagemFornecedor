unit untFormularioBuscaEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Grids, Vcl.DBGrids;

type
  TformularioBuscaEmpresa = class(TForm)
    btnVoltar: TButton;
    tabela: TDBGrid;
    conexao: TZConnection;
    consulta: TZQuery;
    consultaid: TIntegerField;
    consultanome: TWideStringField;
    conector: TDataSource;
    consultacnpj: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure tabelaCellClick(Column: TColumn);
    procedure tabelaColEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    idEmpresa: String;
    nomeEmpresa: String;
  end;

var
  formularioBuscaEmpresa: TformularioBuscaEmpresa;

implementation

{$R *.dfm}

procedure TformularioBuscaEmpresa.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioBuscaEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //formularioBuscaEmpresa := nil;
end;

procedure TformularioBuscaEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioBuscaEmpresa.FormShow(Sender: TObject);
begin
  consulta.Open;
end;

procedure TformularioBuscaEmpresa.tabelaCellClick(Column: TColumn);
begin
  idEmpresa := consulta.FieldByName('id').AsString;
  nomeEmpresa := consulta.FieldByName('nome').AsString;
  Self.Close;
end;

procedure TformularioBuscaEmpresa.tabelaColEnter(Sender: TObject);
begin
  idEmpresa := consulta.FieldByName('id').AsString;
  nomeEmpresa := consulta.FieldByName('nome').AsString;
  Self.Close;
end;

end.
