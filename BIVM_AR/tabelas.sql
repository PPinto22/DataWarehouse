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
    primary key(source,source_id)
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
    primary key(source,source_id)
);

drop table if exists predimutilizador_update;
create table predimutilizador_update (
    source int,
    source_id varchar(15),
    email varchar(75),
    nome varchar(75),
    profissao varchar(45),
    genero varchar(45),
    data_nascimento date,    
    data_update Datetime,
    primary key(source,source_id)
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
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),    
    primary key(source,source_id)
);

drop table if exists predimmaquina_update;
create table predimmaquina_update (
    source int,
    source_id varchar(15),
    modelo varchar(75),
    renda decimal(6,2),
    capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    data_update Datetime,
    primary key(source,source_id)
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
    source_id varchar(15) not null,
    primary key (id,source,source_id)
);

drop table if exists LTutilizador;
create table LTutilizador (
    id int not null,
    source int not null,
    source_id varchar(15) not null,
    primary key (id,source,source_id)
);

drop table if exists QuarProduto;
create table QuarProduto (
    source int,
    source_id varchar(15),
    nome varchar(45),
    descricao varchar(150),
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
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    descricao varchar(150),
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

