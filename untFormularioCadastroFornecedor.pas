unit untFormularioCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset, DateUtils, StrUtils,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection, Vcl.StdCtrls, Math,
  Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,IdURI;

type
  TTipoCampo = record
    IsNull: Boolean;
    DataHora: TDateTime;
  end;
  TformularioCadastroFornecedor = class(TForm)
    editRg: TLabeledEdit;
    editNome: TLabeledEdit;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    conexao: TZConnection;
    consulta: TZQuery;
    editEndereco: TLabeledEdit;
    editCidade: TLabeledEdit;
    editEmpresa: TLabeledEdit;
    editUf: TLabeledEdit;
    editBairro: TLabeledEdit;
    editNumero: TLabeledEdit;
    editComplemento: TLabeledEdit;
    editCnpj: TMaskEdit;
    lblCnpj: TLabel;
    Label1: TLabel;
    editCep: TMaskEdit;
    Label2: TLabel;
    editNascimento: TDateEdit;
    editNomeEmpresa: TEdit;
    btnBuscarEmpresa: TButton;
    IdHTTP1: TIdHTTP;
    btnTelefone: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure editCepExit(Sender: TObject);
    procedure btnTelefoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idFornecedor: String;
    pessoaFisica: Boolean;
    function DataValida(Data: String): TTipocampo;
    function ObterTagXML(const XML: String; Tag: String): String;
    procedure PesquisaCEP(CEP: String);
  end;

var
  formularioCadastroFornecedor: TformularioCadastroFornecedor;

implementation

{$R *.dfm}

uses untFormularioBuscaEmpresa, untFormularioTelefones;

procedure TformularioCadastroFornecedor.btnBuscarEmpresaClick(Sender: TObject);
begin
  if (not Assigned(formularioBuscaEmpresa)) then
    formularioBuscaEmpresa := TformularioBuscaEmpresa.Create(Application);
  formularioBuscaEmpresa.Showmodal;

  if(formularioBuscaEmpresa.idEmpresa <> '') then
  begin
    editEmpresa.Text := formularioBuscaEmpresa.idEmpresa;
    editNomeEmpresa.Text := formularioBuscaEmpresa.nomeEmpresa;
    btnGravar.SetFocus;
  end;

  FreeAndNil(formularioBuscaEmpresa);
end;

procedure TformularioCadastroFornecedor.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioCadastroFornecedor.btnExcluirClick(Sender: TObject);
begin

  if(idFornecedor = '') then
    exit;

  if MessageDlg('Confirma a exclusão do registro ?',mtConfirmation, [mbYes,mbNo],0) = mrNo then
  begin
    exit;
  end;

  consulta.SQL.Text := 'SELECT count(1) as contador ' +
                       'FROM telefone_fornecedor WHERE id_fornecedor = ' + idFornecedor;
  consulta.Open;

  if(consulta.FieldByName('contador').AsInteger > 0) then
  begin
    MessageDlg('Impossível excluir empresa, já existe fornecedor relacionado.',mtError,[mbOk],0);
    exit;
  end;

  with(consulta) do
  begin
    SQL.Text := ' DELETE FROM fornecedor ' +
                ' WHERE id = ' + idFornecedor;
    ExecSQL;
  end;

  consulta.Close;
  Self.Close;
end;

procedure TformularioCadastroFornecedor.btnGravarClick(Sender: TObject);
var
  dataAtual: Tdatetime;
begin

  if(editCnpj.Text = '') then
  begin
    MessageDlg('Preencha o C.N.P.J. do fornecedor',mtError,[mbOk],0);
    editCnpj.SetFocus;
    exit;
  end;

  if(pessoaFisica) then
  begin
    if(editRg.Text = '') then
    begin
      MessageDlg('Preencha o RG do fornecedor',mtError,[mbOk],0);
      editRg.SetFocus;
      exit;
    end;

      if(editNascimento.Text = '') then
    begin
      MessageDlg('Preencha a data de nascimento do fornecedor',mtError,[mbOk],0);
      editNascimento.SetFocus;
      exit;
    end;
  end;

  if(editNome.Text = '') then
  begin
    MessageDlg('Preencha o nome do fornecedor',mtError,[mbOk],0);
    editNome.SetFocus;
    exit;
  end;

  if(editCep.Text = '') then
  begin
    MessageDlg('Preencha o cep',mtError,[mbOk],0);
    editCep.SetFocus;
    exit;
  end;

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

  if(UpperCase(editCidade.Text) = 'FEIRA DE SANTANA') then
  begin

    consulta.SQL.Text := 'SELECT CURRENT_DATE as data';
    consulta.Open;
    dataAtual := consulta.FieldByName('data').AsDateTime;

    if(YearsBetween(strtodatetime(editNascimento.Text),dataAtual) < 18) then
    begin
      MessageDlg('Não é permitido fornecedor de Feira de santana menor de idade',mtError,[mbOk],0);
      editNascimento.SetFocus;
      exit;
    end;
  end;

    if(editCidade.Text = '') then
  begin
    MessageDlg('Preencha a cidade',mtError,[mbOk],0);
    editCidade.SetFocus;
    exit;
  end;

  if(editBairro.Text = '') then
  begin
    MessageDlg('Preencha o bairro',mtError,[mbOk],0);
    editBairro.SetFocus;
    exit;
  end;

  if(editEndereco.Text = '') then
  begin
    MessageDlg('Preencha o endereço',mtError,[mbOk],0);
    editEndereco.SetFocus;
    exit;
  end;

  if(editNumero.Text = '') then
  begin
    MessageDlg('Preencha o número',mtError,[mbOk],0);
    editNumero.SetFocus;
    exit;
  end;

  if(editEmpresa.Text = '') then
  begin
    MessageDlg('Escolha a empresa',mtError,[mbOk],0);
    btnBuscarEmpresa.SetFocus;
    exit;
  end;

  consulta.SQL.Text := 'SELECT Count(1) as contador FROM fornecedor WHERE id = ' + editCnpj.Text;
  consulta.Open;

  if(consulta.FieldByName('contador').AsInteger > 0) then
  begin
    MessageDlg('C.N.P.J. já cadastrado',mtError,[mbOk],0);
    editCnpj.SetFocus;
    consulta.Close;
    exit;
  end;

  with(consulta) do
  begin
    if(idFornecedor = '') then
    begin
      SQL.Text := ' INSERT INTO fornecedor ' +
                  ' (id_empresa, ' +
                  ' nome, ' +
                  ' cnpj_cpf, ' +
                  ' rg, ' ;
      if(pessoaFisica) then
                  SQL.Text := SQL.Text + ' data_nascimento, ' ;
                  SQL.Text := SQL.Text + ' cep, ' +
                  ' logradouro, ' +
                  ' numero, ' +
                  ' bairro, ' +
                  ' cidade, ' +
                  ' uf, ' +
                  ' complemento) ' +
                  ' VALUES ' +
                  '(:id_empresa, ' +
                  ' :nome, ' +
                  ' :cnpj_cpf, ' +
                  ' :rg, ' ;
      if(pessoaFisica) then
                  SQL.Text := SQL.Text + ' :data_nascimento, ' ;
                  SQL.Text := SQL.Text + ' :cep, ' +
                  ' :logradouro, ' +
                  ' :numero, ' +
                  ' :bairro, ' +
                  ' :cidade, ' +
                  ' :uf, ' +
                  ' :complemento) ';

      ParamByName('id_empresa').AsInteger := StrToInt(editEmpresa.Text);
      ParamByName('nome').AsString := editNome.Text;
      ParamByName('cnpj_cpf').AsString := editCnpj.Text;
      ParamByName('rg').AsString := editRg.Text;
      if(pessoaFisica) then
        ParamByName('data_nascimento').AsDate := strtodatetime(editNascimento.Text);
      ParamByName('cep').AsString := editCep.Text;
      ParamByName('logradouro').AsString := editEndereco.Text;
      ParamByName('numero').AsString := editNumero.Text;
      ParamByName('bairro').AsString := editBairro.Text;
      ParamByName('cidade').AsString := editCidade.Text;
      ParamByName('uf').AsString := editUf.Text;
      ParamByName('complemento').AsString := editComplemento.Text;
      ExecSQL;
      MessageDlg('Registro inserido com sucesso',mtConfirmation ,[mbOk],0);
    end
    else
    begin
      SQL.Text := ' UPDATE fornecedor SET ' +
                  ' id_empresa = :id_empresa, ' +
                  ' nome = :nome, ' +
                  ' cnpj_cpf = :cnpj_cpf, ' +
                  ' rg = :rg, ' ;

      if(pessoaFisica) then
                  SQL.Text := SQL.Text + ' data_nascimento = :data_nascimento, ' ;

                 SQL.Text := SQL.Text +  ' cep = :cep, ' +
                  ' logradouro = :logradouro, ' +
                  ' numero = :numero, ' +
                  ' bairro = :bairro, ' +
                  ' cidade = :cidade, ' +
                  ' uf = :uf, ' +
                  ' complemento = :complemento ' +
                  ' WHERE id = :id' ;

      ParamByName('id_empresa').AsInteger := StrToInt(editEmpresa.Text);
      ParamByName('nome').AsString := editNome.Text;
      ParamByName('cnpj_cpf').AsString := editCnpj.Text;
      ParamByName('rg').AsString := editRg.Text;

      if(pessoaFisica) then
      ParamByName('data_nascimento').AsDate := strtodatetime(editNascimento.Text);

      ParamByName('cep').AsString := editCep.Text;
      ParamByName('logradouro').AsString := editEndereco.Text;
      ParamByName('numero').AsString := editNumero.Text;
      ParamByName('bairro').AsString := editBairro.Text;
      ParamByName('cidade').AsString := editCidade.Text;
      ParamByName('uf').AsString := editUf.Text;
      ParamByName('complemento').AsString := editComplemento.Text;
      ParamByName('id').AsInteger := StrToInt(idFornecedor);
      ExecSQL;
      MessageDlg('Registro alterado com sucesso',mtConfirmation ,[mbOk],0);
    end;
  end;

  consulta.Close;

  Self.Close;
end;

procedure TformularioCadastroFornecedor.btnTelefoneClick(Sender: TObject);
begin
if (not Assigned(formularioTelefones)) then
    formularioTelefones := TformularioTelefones.Create(Application);
      formularioTelefones.idFornecedor := idFornecedor;
      formularioTelefones.Showmodal;
end;

procedure TformularioCadastroFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formularioCadastroFornecedor := nil;
end;

procedure TformularioCadastroFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0);

  if(Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TformularioCadastroFornecedor.FormShow(Sender: TObject);
begin

  pessoaFisica := False;
  if(idFornecedor <> '') then
  begin
    consulta.SQL.Text := 'SELECT * FROM fornecedor WHERE id = ' + idFornecedor;
    consulta.Open;

    editCnpj.Text := consulta.FieldByName('cnpj_cpf').AsString;
    editRg.Text := consulta.FieldByName('rg').AsString;
    editNascimento.Text := consulta.FieldByName('data_nascimento').AsString;
    editNome.Text := consulta.FieldByName('nome').AsString;
    editCep.Text := consulta.FieldByName('cep').AsString;
    editUf.Text := consulta.FieldByName('uf').AsString;
    editCidade.Text := consulta.FieldByName('cidade').AsString;
    editBairro.Text := consulta.FieldByName('bairro').AsString;
    editEndereco.Text := consulta.FieldByName('logradouro').AsString;
    editNumero.Text := consulta.FieldByName('numero').AsString;
    editComplemento.Text := consulta.FieldByName('complemento').AsString;
    editEmpresa.Text := consulta.FieldByName('id_empresa').AsString;

    if(Length(editCnpj.Text) = 11) then
      pessoaFisica := True;

    consulta.Close;

    btnExcluir.Visible := True;
  end
  else
  begin
    btnExcluir.Visible := False;
    btnTelefone.Visible := False;

    if MessageDlg('Cadastro será de pessoa física ?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
      pessoaFisica := True;
  end;

  if(pessoaFisica) then
  begin
    lblCnpj.Caption := 'C.P.F.';
    editCnpj.EditMask := '000.000.000-00;0;_';
  end
  else
  begin
    editNascimento.Enabled := False;
    editRg.Enabled := False;
  end;

  editCnpj.SetFocus;
end;

function TformularioCadastroFornecedor.DataValida(Data: String): TTipocampo;
var
  DataInicial: TDateTime;
begin
  Result.IsNull := True;
  Result.DataHora := Date;
  if (TryStrToDate(Data, DataInicial)) then
  begin
    Result.IsNull := False;
    Result.DataHora := DataInicial;
  end;
end;

procedure TformularioCadastroFornecedor.editCepExit(Sender: TObject);
begin
   PesquisaCEP(editCep.Text);
end;

function TformularioCadastroFornecedor.ObterTagXML(const XML: String; Tag: String): String;
var
  Posini: Integer;
  Posfim: Integer;
  Tag2: String;
  EndTag: String;
begin
  Result := '';
  Tag2 := '<' + Tag + '>';
  EndTag := '</' + Tag + '>';
  Posini := Pos(Tag2, XML);
  Posfim := Pos(EndTag, XML);
  if (Posini > 0) then
  begin
    inc(PosIni, Length(Tag2));
    Result := Copy(XML, Posini, (PosFim - PosIni));
  end;
end;

procedure TformularioCadastroFornecedor.PesquisaCEP(CEP: String);
var
  Resposta: WideString;
  Bairro : String;
  consultaCEP: TZQuery;
begin
  inherited;
  // Pesquisa primeiro na base local
  consultaCEP := TZQuery.Create(Application);
  consultaCEP.Connection := conexao;

 	try
    IdHTTP1.AllowCookies 				:= True;
    IdHTTP1.HandleRedirects 		:= True;
    IdHTTP1.Request.UserAgent 	:= Format('Mozilla/%d.0 (Windows NT %d.%d; rv:2.0.1) Gecko/20100101 Firefox/%d.%d.%d', [RandomRange(3, 5), RandomRange(3, 5), Random(2), RandomRange(3, 5), Random(5), Random(5)]);
    IdHTTP1.Request.Accept 			:= 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
    IdHTTP1.Request.AcceptLanguage := 'en-GB,en;q=0.5';
    IdHTTP1.Request.Connection 	:= 'keep-alive';
    IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
    Resposta 										:= IdHTTP1.Get(TIdURI.URLEncode('http://viacep.com.br/ws/' +
                       CEP +
                       '/xml/'));

  except on E: Exception do
    begin
      MessageDlg('Erro, cep não encontrado',mtError,[mbOk],0);
      Exit;
    end;
  end;

  if (ObterTagXML(Resposta, 'erro') <> '') then
  begin
    Exit;
  end;

  editUf.Text	         := UTF8Decode(ObterTagXML(Resposta, 'uf'));
  editCidade.Text			 := UTF8Decode(ObterTagXML(Resposta, 'localidade'));
  editBairro.Text			 := UTF8Decode(ObterTagXML(Resposta, 'bairro'));
  editEndereco.Text    := UTF8Decode(ObterTagXML(Resposta, 'logradouro'));
  editComplemento.Text := UTF8Decode(ObterTagXML(Resposta, 'complemento'));
  consultaCEP.Close;
end;

end.
