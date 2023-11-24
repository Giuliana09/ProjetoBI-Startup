CREATE DATABASE imoveisFacilite; 

CREATE TABLE Usuario (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  nome VARCHAR(30)  NULL  ,
  celular VARCHAR(20)  NULL  ,
  email VARCHAR(35)  NULL  ,
  cpf VARCHAR(20)  NULL  ,
  rg VARCHAR(20)  NULL  ,
  dataDeNascimento DATE  NULL  ,
  endereco VARCHAR(35)  NULL  ,
  estado VARCHAR(20)  NULL  ,
  cidade VARCHAR(25)  NULL  ,
  genero VARCHAR(2)  NULL  ,
  dataCadastro DATETIME  NULL  ,
  estadoCivil VARCHAR(15)  NULL  ,
  profissao VARCHAR(25)  NULL  ,
  nacionalidade VARCHAR(30)  NULL  ,
  emailUsuario VARCHAR(45)  NULL    ,
PRIMARY KEY(id));

CREATE TABLE Corretor (
  id INTEGER UNSIGNED  NOT NULL   ,
  Usuario_id INTEGER UNSIGNED  NOT NULL  ,
  experiencia TEXT  NULL  ,
  creci VARCHAR(8)  NULL  ,
  regiaoDeAtuacao VARCHAR(20)  NULL  ,
  comissao DECIMAL(10,2)  NULL    ,
PRIMARY KEY(id)  ,
   FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id));



CREATE TABLE Fiador (
  id INTEGER UNSIGNED  NOT NULL   ,
  Usuario_id INTEGER UNSIGNED  NOT NULL  ,
  rendaMensal DECIMAL(10,2)  NULL  ,
  comprovanteEndereco VARCHAR(50)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id));

CREATE TABLE Bem (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Fiador_id INTEGER UNSIGNED  NOT NULL  ,
  tipo VARCHAR(20)  NULL  ,
  valor DECIMAL(10,2)  NULL  ,
  documento VARCHAR(20)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Fiador_id)
    REFERENCES Fiador(id));


CREATE TABLE Inquilino (
  id INTEGER UNSIGNED  NOT NULL   ,
  Usuario_id INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id));


CREATE TABLE Comprador (
  id INTEGER UNSIGNED  NOT NULL   ,
  Usuario_id INTEGER UNSIGNED  NOT NULL  ,
  orcamentoMaximo DECIMAL(10,2)  NULL  ,
  orcamentoMinimo DECIMAL(10,2)  NULL  ,
  preferenciaDeImovel VARCHAR(20)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id));
      

CREATE TABLE Condominio (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  nome VARCHAR(20)  NULL  ,
  valorMensal DECIMAL(10,2)  NULL  ,
  tipo VARCHAR(10)  NULL  ,
  restricoes TEXT  NULL  ,
  endereco VARCHAR(30)  NULL    ,
PRIMARY KEY(id));

CREATE TABLE ComodidadesCondominio (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Condominio_id INTEGER UNSIGNED  NOT NULL  ,
  nome VARCHAR(25)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Condominio_id)
    REFERENCES Condominio(id));


CREATE TABLE DadoPagamento (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  banco VARCHAR(30)  NULL  ,
  agencia VARCHAR(6)  NULL  ,
  conta VARCHAR(10)  NULL  ,
  tipoConta VARCHAR(10)  NULL  ,
  titularConta VARCHAR(30)  NULL  ,
  cpfTitular VARCHAR(15)  NULL  ,
  pix VARCHAR(33)  NULL    ,
PRIMARY KEY(id));


CREATE TABLE Proprietario (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  DadoPagamento_id INTEGER UNSIGNED  NOT NULL  ,
  Usuario_id INTEGER UNSIGNED  NOT NULL  ,
  taxaAdm  DECIMAL(4,2) NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id),
  FOREIGN KEY(DadoPagamento_id)
    REFERENCES DadoPagamento(id));

CREATE TABLE Imovel (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Condominio_id INTEGER UNSIGNED  NOT NULL  ,
  Proprietario_id INTEGER UNSIGNED  NOT NULL  ,
  tipo VARCHAR(15)  NULL  ,
  endereco VARCHAR(30)  NULL  ,
  regiao VARCHAR(15)  NULL  ,
  estado VARCHAR(20)  NULL  ,
  cidade VARCHAR(25)  NULL  ,
  qtdQuartos INT  NULL  ,
  qtdBanheiro INT  NULL  ,
  qtdGaragem INT  NULL  ,
  tamanho DECIMAL  NULL  ,
  fotoImovel VARCHAR(50)  NULL  ,
  fornecedorEnergia VARCHAR(30)  NULL  ,
  fornecedorAgua VARCHAR(30)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Proprietario_id)
    REFERENCES Proprietario(id),
  FOREIGN KEY(Condominio_id)
    REFERENCES Condominio(id));


CREATE TABLE ContratoDeLocacao (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Fiador_id INTEGER UNSIGNED  NOT NULL  ,
  Imovel_id INTEGER UNSIGNED  NOT NULL  ,
  dataInicio DATETIME  NULL  ,
  dataFinal DATETIME  NULL  ,
  valorAluguel DECIMAL(10,2)  NULL  ,
  condicoes TEXT  NULL  ,
  multa DECIMAL(10,2)  NULL  ,
  tipoPagamento VARCHAR(20)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Imovel_id)
    REFERENCES Imovel(id),
  FOREIGN KEY(Fiador_id)
    REFERENCES Fiador(id));

CREATE TABLE ContratoDeVenda (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Comprador_id INTEGER UNSIGNED  NOT NULL  ,
  Imovel_id INTEGER UNSIGNED  NOT NULL  ,
  valor DECIMAL(10,2)  NULL  ,
  condicoes TEXT  NULL  ,
  dataContratoVd DATETIME  NULL  ,
  tipoPagamento VARCHAR(20)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Imovel_id)
    REFERENCES Imovel(id),
  FOREIGN KEY(Comprador_id)
    REFERENCES Comprador(id));



CREATE TABLE ConsolidaVenda (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Corretor_id INTEGER UNSIGNED  NOT NULL  ,
  ContratoDeVenda_id INTEGER UNSIGNED  NOT NULL  ,
  dataConsolidaVd DATETIME  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(ContratoDeVenda_id)
    REFERENCES ContratoDeVenda(id),
  FOREIGN KEY(Corretor_id)
    REFERENCES Corretor(id));

CREATE TABLE ConsolidaLocacao (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Corretor_id INTEGER UNSIGNED  NOT NULL  ,
  ContratoDeLocacao_id INTEGER UNSIGNED  NOT NULL  ,
  dataLocacao DATETIME  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(ContratoDeLocacao_id)
    REFERENCES ContratoDeLocacao(id),
  FOREIGN KEY(Corretor_id)
    REFERENCES Corretor(id));

CREATE TABLE HistoricoVisitacao (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Corretor_id INTEGER UNSIGNED  NOT NULL  ,
  Imovel_id INTEGER UNSIGNED  NOT NULL  ,
  dataVisitacao DATETIME  NULL  ,
  observacoes TEXT  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Imovel_id)
    REFERENCES Imovel(id),
  FOREIGN KEY(Corretor_id)
    REFERENCES Corretor(id));



CREATE TABLE HistoricoManutencao (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Imovel_id INTEGER UNSIGNED  NOT NULL  ,
  problema VARCHAR(20)  NULL  ,
  dataSolitacao DATETIME  NULL  ,
  dataManutencao DATETIME  NULL  ,
  custo DECIMAL(10,2)  NULL  ,
  profissionalContratado VARCHAR(20)  NULL  ,
  contatoDoProfissional VARCHAR(20)  NULL    ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(Imovel_id)
    REFERENCES Imovel(id));



CREATE TABLE ContratoInquilino (
  Inquilino_id INTEGER UNSIGNED  NOT NULL  ,
  ContratoDeLocacao_id INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(Inquilino_id, ContratoDeLocacao_id)  ,
  FOREIGN KEY(Inquilino_id)
    REFERENCES Inquilino(id),
  FOREIGN KEY(ContratoDeLocacao_id)
    REFERENCES ContratoDeLocacao(id));




