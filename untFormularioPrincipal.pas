unit untFormularioPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Data.DB, Data.SqlExpr,
  Data.FMTBcd, Datasnap.DBClient, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection;

type
  TformularioPrincipal = class(TForm)
    btnFechar: TSpeedButton;
    btnEmpresa: TSpeedButton;
    btnFornecedor: TSpeedButton;
    btnImprimir: TSpeedButton;
    conexao: TZConnection;
    consulta: TZQuery;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnFornecedorClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formularioPrincipal: TformularioPrincipal;

implementation

{$R *.dfm}

uses untFormularioCadastroEmpresa, untFormularioListagemEmpresas,
  untFormularioListagemFornecedores, untFormularioImpressao;

procedure TformularioPrincipal.btnEmpresaClick(Sender: TObject);
begin

if (not Assigned(formularioListagemEmpresas)) then
    formularioListagemEmpresas := TformularioListagemEmpresas.Create(Application);
  formularioListagemEmpresas.Showmodal;
end;

procedure TformularioPrincipal.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioPrincipal.btnFornecedorClick(Sender: TObject);
begin
if (not Assigned(formularioListagemFornecedores)) then
    formularioListagemFornecedores := TformularioListagemFornecedores.Create(Application);
  formularioListagemFornecedores.Showmodal;
end;

procedure TformularioPrincipal.btnImprimirClick(Sender: TObject);
begin
if (not Assigned(formularioImpressao)) then
    formularioImpressao := TformularioImpressao.Create(Application);
  formularioImpressao.Showmodal;
end;

procedure TformularioPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formularioPrincipal := nil;
end;

procedure TformularioPrincipal.FormCreate(Sender: TObject);
var
  arq: TextFile;
  contador: Integer;
  diretorio, arquivo, servidor, banco, linha: String;
begin
  try

    diretorio := extractfilepath(Application.ExeName);
    arquivo := diretorio + '\endereco_banco.txt';
    if (FileExists(arquivo)) then
    begin
      AssignFile(arq, arquivo);
      contador := 0;
{$I-}
      Reset(arq);
{$I+}
      while (not Eof(arq)) do
      begin
        readln(arq, linha);

        if (contador = 1) then
          readln(arq, servidor);

        if (contador = 3) then
          readln(arq, banco);

        contador := contador + 1;
      end;

      conexao.HostName := servidor;
      conexao.Database := banco;
      conexao.Connect;
      conexao.DbcConnection.CreateStatement.ExecuteQuery('BEGIN TRANSACTION');
      conexao.DbcConnection.CreateStatement.ExecuteQuery('COMMIT');
      CloseFile(arq);

    end
    else
    begin
      AssignFile(arq, arquivo);
      Rewrite(arq);
      Writeln(arq, '------------------------');
      Writeln(arq, 'Servidor');
      Writeln(arq, '127.0.0.1');
      Writeln(arq, '------------------------');
      Writeln(arq, 'Banco');
      Writeln(arq, 'banco_1');
      Writeln(arq, '------------------------');
      CloseFile(arq);
    end;
  except
  end;
end;

end.
