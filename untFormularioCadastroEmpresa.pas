unit untFormularioCadastroEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Mask;

type
  TformularioCadastroEmpresa = class(TForm)
    conexao: TZConnection;
    consulta: TZQuery;
    editUf: TLabeledEdit;
    editNome: TLabeledEdit;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    lblCnpj: TLabel;
    editCnpj: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idEmpresa: String;
  end;

var
  formularioCadastroEmpresa: TformularioCadastroEmpresa;

implementation

{$R *.dfm}

procedure TformularioCadastroEmpresa.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioCadastroEmpresa.btnExcluirClick(Sender: TObject);
begin
  if(idEmpresa = '') then
    exit;

  if MessageDlg('Confirma a exclusão do registro ?',mtConfirmation, [mbYes,mbNo],0) = mrNo then
  begin
    exit;
  end;

  consulta.SQL.Text := 'SELECT count(1) as contador ' +
                       'FROM fornecedor WHERE id_empresa = ' + idEmpresa;
  consulta.Open;

  if(consulta.FieldByName('contador').AsInteger > 0) then
  begin
    MessageDlg('Impossível excluir empresa, já existe fornecedor relacionado.',mtError,[mbOk],0);
    exit;
  end;

  with(consulta) do
  begin
    SQL.Text := ' DELETE FROM empresa ' +
                ' WHERE id = ' + idEmpresa;
    ExecSQL;
  end;

  consulta.Close;
  Self.Close;

end;

procedure TformularioCadastroEmpresa.btnGravarClick(Sender: TObject);
begin
  if(editUf.Text = '') then
  begin
    MessageDlg('Preencha a unidade federativa',mtError,[mbOk],0);
    editUf.SetFocus;
    exit;
  end;

  if(Length(editUf.Text) <> 2) then
  begin
    MessageDlg('Preencha a unidade federativa corretamente',mtError,[mbOk],0);
    editUf.SetFocus;
    exit;
  end;

  if(editCnpj.Text = '') then
  begin
    MessageDlg('Preencha o C.N.P.J. da empresa',mtError,[mbOk],0);
    editCnpj.SetFocus;
    exit;
  end;

  if(Length(editCnpj.Text) <> 14) then
  begin
    MessageDlg('Preencha o C.N.P.J. corretamente',mtError,[mbOk],0);
    editCnpj.SetFocus;
    exit;
  end;

  if(editNome.Text = '') then
  begin
    MessageDlg('Preencha o nome da empresa',mtError,[mbOk],0);
    editNome.SetFocus;
    exit;
  end;

  consulta.SQL.Text := 'SELECT Count(1) as contador FROM empresa WHERE id = ' + editCnpj.Text;
  consulta.Open;

  if(consulta.FieldByName('contador').AsInteger > 0) then
  begin
    MessageDlg('C.N.P.J. já cadastrado',mtError,[mbOk],0);
    editCnpj.SetFocus;
    consulta.Close;
    exit;
  end;

  consulta.Close;

  with(consulta) do
  begin
    if(idEmpresa = '') then
    begin
      SQL.Text := 'INSERT INTO empresa ' +
                  '(uf , ' +
                  'cnpj , ' +
                  'nome)  ' +
                  'VALUES' +
                  '( :uf , ' +
                  ' :cnpj , ' +
                  ' :nome) ' ;

      ParamByName('uf').AsString := editUf.Text;
      ParamByName('cnpj').AsString := editCnpj.Text;
      ParamByName('nome').AsString := UpperCase(editNome.Text);
      ExecSQL;
      MessageDlg('Registro inserido com sucesso',mtConfirmation ,[mbOk],0);
    end
    else
    begin
      SQL.Text := 'UPDATE empresa SET ' +
                  'uf = :uf, ' +
                  'cnpj = :cnpj , ' +
                  'nome = :nome   ' +
                  ' WHERE id = :id' ;

      ParamByName('uf').AsString := editUf.Text;
      ParamByName('cnpj').AsString := editCnpj.Text;
      ParamByName('nome').AsString := UpperCase(editNome.Text);
      ParamByName('id').AsInteger := StrToInt(idEmpresa);
      ExecSQL;
      MessageDlg('Registro alterado com sucesso',mtConfirmation ,[mbOk],0);
    end;
  end;

  consulta.Close;

  Self.Close;

end;

procedure TformularioCadastroEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   formularioCadastroEmpresa := nil;
end;

procedure TformularioCadastroEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0);

  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioCadastroEmpresa.FormShow(Sender: TObject);
begin

  if(idEmpresa <> '') then
  begin
    consulta.SQL.Text := 'SELECT * FROM EMPRESA WHERE id = ' + idEmpresa;
    consulta.Open;

    editCnpj.Text := consulta.FieldByName('cnpj').AsString;
    editUf.Text := consulta.FieldByName('uf').AsString;
    editNome.Text := consulta.FieldByName('nome').AsString;

    consulta.Close;

    btnExcluir.Visible := True;
  end
  else
  begin
    btnExcluir.Visible := False;
  end;

  editUf.SetFocus;
end;

end.
