unit untFormularioListagemFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractConnection,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TformularioListagemFornecedores = class(TForm)
    btnNovo: TButton;
    tabela: TDBGrid;
    Label1: TLabel;
    btnVoltar: TButton;
    conector: TDataSource;
    consulta: TZQuery;
    consultaid: TIntegerField;
    consultauf: TWideStringField;
    consultanome: TWideStringField;
    consultacnpj: TWideStringField;
    conexao: TZConnection;
    consultanome_empresa: TWideStringField;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tabelaCellClick(Column: TColumn);
    procedure btnNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formularioListagemFornecedores: TformularioListagemFornecedores;

implementation

{$R *.dfm}

uses untFormularioCadastroFornecedor;

procedure TformularioListagemFornecedores.btnNovoClick(Sender: TObject);
begin
  if (not Assigned(formularioCadastroFornecedor)) then
    formularioCadastroFornecedor := TformularioCadastroFornecedor.Create(Application);
  formularioCadastroFornecedor.Showmodal;

  consulta.Close;
  consulta.Open;
end;

procedure TformularioListagemFornecedores.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioListagemFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formularioListagemFornecedores := nil;
end;

procedure TformularioListagemFornecedores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioListagemFornecedores.FormShow(Sender: TObject);
begin
  consulta.Open;
end;

procedure TformularioListagemFornecedores.tabelaCellClick(Column: TColumn);
begin

  if (not Assigned(formularioCadastroFornecedor)) then
    formularioCadastroFornecedor := TformularioCadastroFornecedor.Create(Application);
  formularioCadastroFornecedor.idFornecedor := consulta.FieldByName('id').AsString;
  formularioCadastroFornecedor.Showmodal;

  consulta.Close;
  consulta.Open;
end;

end.
