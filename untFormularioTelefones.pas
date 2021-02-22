unit untFormularioTelefones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, ZAbstractConnection, ZConnection, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Vcl.Mask;

type
  TformularioTelefones = class(TForm)
    btnCancelar: TButton;
    btnGravar: TButton;
    btnExcluir: TButton;
    conector: TDataSource;
    consulta: TZQuery;
    consultaid: TIntegerField;
    conexao: TZConnection;
    tabela: TDBGrid;
    consultaid_fornecedor: TIntegerField;
    consultatelefone: TWideStringField;
    editTelefone: TMaskEdit;
    lblTelefone: TLabel;
    consulta_2: TZQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    idFornecedor: String;
  end;

var
  formularioTelefones: TformularioTelefones;

implementation

{$R *.dfm}

procedure TformularioTelefones.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioTelefones.btnExcluirClick(Sender: TObject);
begin
  if(consulta.FieldByName('id').AsString = '') then
    exit;

  if MessageDlg('Confirma a exclusão do registro ?',mtConfirmation, [mbYes,mbNo],0) = mrNo then
  begin
    exit;
  end;

  with(consulta_2) do
  begin
    SQL.Text := ' DELETE FROM telefone_fornecedor ' +
                ' WHERE id_fornecedor = ' + idFornecedor +
                ' AND id = ' + consulta.FieldByName('id').AsString;
    ExecSQL;
  end;

  consulta_2.Close;

  consulta.Close;
  consulta.Open;
end;

procedure TformularioTelefones.btnGravarClick(Sender: TObject);
begin

  if(Length(editTelefone.Text) <> 13) then
  begin
    MessageDlg('Preencha o telefone corretamente',mtError,[mbOk],0);
    editTelefone.SetFocus;
    exit;
  end;

  consulta_2.SQL.Text := 'SELECT count(1) as contador FROM telefone_fornecedor ' +
                       ' WHERE id_fornecedor = ' + idFornecedor +
                       ' AND telefone = ' + QuotedStr(editTelefone.Text);
  consulta_2.Open;

  if(consulta_2.FieldByName('contador').AsInteger > 0) then
  begin
    MessageDlg('Telefone já cadastrado',mtError,[mbOk],0);
    editTelefone.SetFocus;
    consulta_2.Close;
    exit;
  end;
  consulta_2.Close;

  with(consulta_2) do
  begin
    SQL.Text := 'INSERT into telefone_fornecedor ' +
                '(id_fornecedor, ' +
                ' telefone)' +
                'VALUES ' +
                '(:id_fornecedor, ' +
                ' :telefone)' ;

    ParamByName('id_fornecedor').AsString := idFornecedor;
    ParamByName('telefone').AsString := editTelefone.Text;
    ExecSQL;
  end;

  consulta.Close;
  consulta.Open;
  editTelefone.Text := '';
  editTelefone.SetFocus;

end;

procedure TformularioTelefones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formularioTelefones := nil;
end;

procedure TformularioTelefones.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0);

  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioTelefones.FormShow(Sender: TObject);
begin
  consulta.Close;
  consulta.SQL.Text := consulta.SQL.Text + ' WHERE id_fornecedor = ' + idFornecedor;
  consulta.Open;
  editTelefone.SetFocus;
end;

end.
