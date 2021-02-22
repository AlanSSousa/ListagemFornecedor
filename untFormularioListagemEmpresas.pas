unit untFormularioListagemEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ZAbstractConnection, ZConnection,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TformularioListagemEmpresas = class(TForm)
    consulta: TZQuery;
    conexao: TZConnection;
    tabela: TDBGrid;
    btnVoltar: TButton;
    conector: TDataSource;
    consultaid: TIntegerField;
    consultauf: TWideStringField;
    consultanome: TWideStringField;
    consultacnpj: TWideStringField;
    btnNovo: TButton;
    Label1: TLabel;
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
  formularioListagemEmpresas: TformularioListagemEmpresas;

implementation

{$R *.dfm}

uses untFormularioCadastroEmpresa;

procedure TformularioListagemEmpresas.btnNovoClick(Sender: TObject);
begin
  if (not Assigned(formularioCadastroEmpresa)) then
    formularioCadastroEmpresa := TformularioCadastroEmpresa.Create(Application);
  formularioCadastroEmpresa.Showmodal;

  consulta.Close;
  consulta.Open;
end;

procedure TformularioListagemEmpresas.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioListagemEmpresas.tabelaCellClick(Column: TColumn);
begin

  if (not Assigned(formularioCadastroEmpresa)) then
    formularioCadastroEmpresa := TformularioCadastroEmpresa.Create(Application);
  formularioCadastroEmpresa.idEmpresa := consulta.FieldByName('id').AsString;
  formularioCadastroEmpresa.Showmodal;

  consulta.Close;
  consulta.Open;
end;

procedure TformularioListagemEmpresas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  formularioListagemEmpresas := nil;
end;

procedure TformularioListagemEmpresas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioListagemEmpresas.FormShow(Sender: TObject);
begin
  consulta.Open;
end;

end.
