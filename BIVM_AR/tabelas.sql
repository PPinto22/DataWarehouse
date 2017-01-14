use bivm_ar;

drop table if exists etl;
create table etl (
    last_load DATETIME,
    last_try DATETIME
);
insert into etl value(null,null);

drop table if exists predimproduto;
create table preDimProduto (
    source int,
    source_id varchar(15),
    nome varchar(45),
    pais varchar(45),
    precoV decimal(6,2),
    precoA decimal(6,2),
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists predimutilizador;
create table preDimUtilizador (
    source int,
    source_id varchar(15),
    email varchar(75),
    nome varchar(75),
    profissao varchar(45),
    genero varchar(45),
    data_nascimento date,
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists predimmaquina;
create table preDimMaquina (
    source int,
    source_id varchar(15),
    modelo varchar(75),
    renda decimal(6,2),
    capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists LTmaquina;
create table LTmaquina (
    id int not null auto_increment,
    source int not null,
    source_id varchar(15) not null,
    primary key (id,source,source_id)
);

drop table if exists LTproduto;
create table LTproduto (
    id int not null,
    source int not null,
    source_id varchar(45) not null,
    primary key (id,source,source_id)
);

drop table if exists LTutilizador;
create table LTutilizador (
    id int not null,
    source int not null,
    source_id varchar(75) not null,
    primary key (id,source,source_id)
);

drop table if exists QuarProduto;
create table QuarProduto (
    source int,
    source_id varchar(15),
    nome varchar(45),
    descricao varchar(150),
	op char(1),
    data datetime default now()
);

drop table if exists QuarUtilizador;
create table QuarUtilizador (
    source int,
    source_id varchar(45),
    email varchar(75),
    nome varchar(75),
    profissao varchar(45),
    genero varchar(45),
    data_nascimento date,
    descricao varchar(150),
	op char(1),
    data datetime default now()
);

drop table if exists QuarMaquina;
create table QuarMaquina(
    source int,
    source_id varchar(15),
    modelo varchar(75),
    renda decimal(6,2),
    capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    descricao varchar(150),
    op char(1),
    data datetime default now()
);

drop table if exists preFactVendas;
create table preFactVendas (
	source int not null,
    precoV decimal(6,2),
    precoA decimal(6,2),
    lucro decimal (6,2),
    data Date,
    hora Time,
    validade date,
    idade int,
    utilizador varchar(15),
    maquina varchar(15),
    produto varchar(15)
);

drop table if exists histproduto;
create table histProduto (
    id int,
    nome_anterior varchar(45),
    nome varchar(45),
    pais_anterior varchar(45),
    pais varchar(45),
    precoV_anterior decimal(6,2),
    precoV decimal(6,2),
    precoA_anterior decimal(6,2),
    precoA decimal(6,2),
	data_update datetime
);

drop table if exists histutilizador;
create table histUtilizador (
    id int,
    email_anterior varchar(75),
    email varchar(75),
    nome_anterior varchar(75),
    nome varchar(75),
    profissao_anterior varchar(45),
    profissao varchar(45),
    data_nascimento_anterior date,
    data_nascimento date,
    genero_anterior varchar(45),
    genero varchar(45),
	data_update datetime
);

drop table if exists histmaquina;
create table histMaquina (
    id int,
    renda_anterior decimal(6,2),
	renda decimal(6,2),
    capacidade_anterior int,
	capacidade int,
    cod_postal_anterior varchar(10),
    cod_postal varchar(10),
    freguesia_anterior varchar(75),
    freguesia varchar(75),
    rua_anterior varchar(75),
    rua varchar(75),
    cidade_anterior varchar(45),
    cidade varchar(45),
    distrito_anterior varchar(45),
    distrito varchar(45),
    pais_anterior varchar(45),
    pais varchar(45),
    data_update datetime
);

