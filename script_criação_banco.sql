CREATE TABLE empresa
(
  id integer NOT NULL DEFAULT nextval('empresa_id_seq'::regclass),
  uf character varying(2) NOT NULL,
  nome character varying(200) NOT NULL,
  cnpj character varying(14) NOT NULL,
  CONSTRAINT empresa_pkey PRIMARY KEY (id)
);
	
CREATE TABLE fornecedor
(
  id integer NOT NULL DEFAULT nextval('fornecedor_id_seq'::regclass),
  id_empresa integer NOT NULL,
  nome character varying(200) NOT NULL,
  cnpj_cpf character varying(14) NOT NULL,
  rg character varying(20),
  data_nascimento date,
  data_cadastro timestamp without time zone NOT NULL DEFAULT now(),
  cep character varying(8) NOT NULL,
  logradouro character varying(200) NOT NULL,
  numero character varying(4),
  bairro character varying(200),
  cidade character varying(200),
  uf character varying(2),
  complemento character varying(200),
  CONSTRAINT fornecedor_pkey PRIMARY KEY (id),
  CONSTRAINT fk_id_empresa FOREIGN KEY (id_empresa)
      REFERENCES empresa (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE telefone_fornecedor
(
  id integer NOT NULL DEFAULT nextval('telefone_fornecedor_id_seq'::regclass),
  id_fornecedor integer NOT NULL,
  telefone character varying(13) NOT NULL,
  CONSTRAINT telefone_fornecedor_pkey PRIMARY KEY (id),
  CONSTRAINT fk_id_fornecedor FOREIGN KEY (id_fornecedor)
      REFERENCES fornecedor (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)