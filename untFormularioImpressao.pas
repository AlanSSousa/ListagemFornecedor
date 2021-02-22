unit untFormularioImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Data.DB, StrUtils,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection;

type
  TformularioImpressao = class(TForm)
    edtNome: TEdit;
    edtDataCadastro: TMaskEdit;
    edtCnpjCpf: TEdit;
    btnImprimir: TButton;
    btnVoltar: TButton;
    lblNome: TLabel;
    lblCnpjCpf: TLabel;
    lblData: TLabel;
    conexao: TZConnection;
    consulta: TZQuery;
    consulta_2: TZQuery;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formularioImpressao: TformularioImpressao;

implementation

{$R *.dfm}

uses untFormularioImpressaoFR;

procedure TformularioImpressao.btnImprimirClick(Sender: TObject);
var
  empresaAtual: String;
  query: String;
  telefones: String;
  primeiroTelefone: Boolean;
begin

  with consulta do
  begin
    SQL.Text := ' SELECT ' +
                ' fo.cnpj_cpf, ' +
                ' fo.id, ' +
                ' fo.nome, ' +
                ' fo.data_cadastro, ' +
                ' fo.uf || '' - '' || fo.cidade || '' - '' || fo.bairro  ' +
                ' || '' - '' || fo.logradouro || '' Nº '' || fo.numero as endereco, ' +
                ' em.cnpj || '' - '' || em.nome as nome_empresa' +
                ' FROM ' +
                ' fornecedor fo ' +
                ' INNER JOIN empresa em ON fo.id_empresa = em.id ' +
                ' WHERE ' +
                ' 1 = 1  ' ;

    if(edtNome.Text <> '') then
       SQL.Text := SQL.Text + ' AND fo.nome ilike ''%' + edtNome.Text + '%''  ' ;


    if(edtCnpjCpf.Text <> '') then
       SQL.Text := SQL.Text + ' AND fo.cnpj_cpf = :cnpj_cpf  ' ;


    if(Trim(StringReplace(edtDataCadastro.Text,'/','',[rfReplaceAll, rfIgnoreCase])) <> '') then
       SQL.Text := SQL.Text + ' AND cast(fo.data_cadastro as date) = :data_cadastro 	 ' ;

    SQL.Text := SQL.Text +
            ' ORDER BY ' +
                ' em.cnpj, ' +
                ' fo.cnpj_cpf ' ;

    if(edtCnpjCpf.Text <> '') then
      ParamByName('cnpj_cpf').AsString := edtCnpjCpf.Text;

    if(Trim(StringReplace(edtDataCadastro.Text,'/','',[rfReplaceAll, rfIgnoreCase])) <> '') then
      ParamByName('data_cadastro').AsDate := strtodatetime(edtDataCadastro.Text);

    Open;
    query := SQL.Text;

    if (not Assigned(formularioImpressaoFR)) then
        formularioImpressaoFR := TformularioImpressaoFR.Create(Application);

    empresaAtual := '';

    formularioImpressaoFR.RLMemo1.Lines.Clear;
    formularioImpressaoFR.RLMemo1.Lines.Add('                         ');
    formularioImpressaoFR.RLMemo1.Lines.Add('                                                            LISTAGEM DE FORNECEDORES                              ');
    formularioImpressaoFR.RLMemo1.Lines.Add('                         ');

    while(not consulta.Eof) do
    begin

      if(empresaAtual <> consulta.FieldByName('nome_empresa').AsString) then
      begin

        formularioImpressaoFR.RLMemo1.Lines.Add('------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
        formularioImpressaoFR.RLMemo1.Lines.Add('Empresa: ' + consulta.FieldByName('nome_empresa').AsString);
        empresaAtual := consulta.FieldByName('nome_empresa').AsString;
        formularioImpressaoFR.RLMemo1.Lines.Add('------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
      end;


      formularioImpressaoFR.RLMemo1.Lines.Add(
      'C.N.P.J./C.P.F.:' + consulta.FieldByName('cnpj_cpf').AsString +
      '      ' +
      'Nome:'  + consulta.FieldByName('nome').AsString +
      '      ' +
      'Cadastro: ' + consulta.FieldByName('data_cadastro').AsString
      );

      formularioImpressaoFR.RLMemo1.Lines.Add(
      'Endereço:' + consulta.FieldByName('endereco').AsString );

      consulta_2.SQL.Text := 'SELECT telefone FROM telefone_fornecedor ' +
                             ' WHERE id_fornecedor = ' + consulta.FieldByName('id').AsString;
      consulta_2.Open;

      primeiroTelefone := True;
      telefones := '';
      while(not consulta_2.Eof) do
      begin
        if(primeiroTelefone) then
          primeiroTelefone := False
        else
          telefones := telefones + ', ';
        telefones := telefones + consulta_2.FieldByName('telefone').AsString;
        consulta_2.Next;
      end;

      if(telefones <> '') then
        formularioImpressaoFR.RLMemo1.Lines.Add('Telefone(s): '+telefones);

      formularioImpressaoFR.RLMemo1.Lines.Add('');
      consulta.Next;
    end;
  end;

  formularioImpressaoFR.Showmodal;
  FreeAndNil(formularioImpressaoFR);
end;

procedure TformularioImpressao.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformularioImpressao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formularioImpressao := nil;
end;

procedure TformularioImpressao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
   perform(WM_NEXTDLGCTL,0,0);
end;

end.
