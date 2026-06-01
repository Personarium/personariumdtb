-- Drop
drop table if exists tb_tipo_documento cascade;
drop table if exists tb_documento cascade;
drop table if exists tb_tipo_pessoa cascade;
drop table if exists tb_pessoa cascade;
drop table if exists tb_pessoa_documento cascade;

-- Tabelas
create table if not exists tb_tipo_pessoa (
    id bigserial not null,
    id_public uuid not null default gen_random_uuid(),
    descricao varchar (80) not null,
    sigla varchar (5) not null,
    date_created timestamp not null default now(),
    date_updated timestamp null,
    date_deleted timestamp null,
    is_active boolean not null default true,
    constraint pk_tipo_pessoa primary key (id),
    constraint un_tipo_pessoa unique (descricao, sigla)
);

create table if not exists tb_pessoa (
    id bigserial not null,
    id_public uuid not null default gen_random_uuid(),
    id_tipo_pessoa bigserial not null,
    nome varchar(80) not null,
    nome_social varchar(255) null,
    nome_fonetico varchar(255) null,
    nome_mae varchar(255) null,
    nome_pai varchar(255) null,
    sexo char(1) null,
    altura numeric(5,2) null,
    peso numeric(5,2) null,
    tipo_sanguineo varchar(10) null,
    date_created timestamp not null default now(),
    date_updated timestamp null,
    date_deleted timestamp null,
    is_active boolean not null default true,
    constraint pk_pessoa primary key (id),
    constraint fk_pessoa_tipo_pessoa foreign key (id_tipo_pessoa) references tb_tipo_pessoa(id)
);

create table if not exists tb_tipo_documento (
    id bigserial not null,
    id_public uuid not null default gen_random_uuid(),
    nome varchar (80) not null,
    sigla varchar(10) not null,
    date_created timestamp not null default now(),
    date_updated timestamp null,
    date_deleted timestamp null,
    is_active boolean not null default true,
    constraint pk_tipo_documento primary key (id),
    constraint un_tipo_documento unique (nome, sigla)
);

create table if not exists tb_documento (
    id bigserial not null,
    id_public uuid not null default gen_random_uuid(),
    id_tipo_documento bigserial not null,
    id_pessoa bigserial not null,
    numero varchar(100) not null,
    data_emissao date null, 
    data_validade date null,
    orgao_emissor varchar(50),
    date_created timestamp not null default now(),
    date_updated timestamp null,
    date_deleted timestamp null,
    is_active boolean not null default true,
    constraint pk_documento primary key (id),
    constraint fk_documento_tipo_documento foreign key (id_tipo_documento) references tb_tipo_documento(id),
    constraint fk_documento_pessoa foreign key (id_pessoa) references tb_pessoa(id),
    constraint un_documento unique (numero)
);

-- Indices
create index in_documento_numero on tb_documento(numero);

create index in_pessoa_nome on tb_pessoa(nome);

-- Insert
insert into tb_tipo_pessoa (descricao, sigla) values ('Pessoa Física', 'PF');
insert into tb_tipo_pessoa (descricao, sigla) values ('Pessoa Jurídica', 'PJ');

insert into tb_tipo_documento (nome, sigla) values ('Cadastro de Pessoa Física', 'CPF');
insert into tb_tipo_documento (nome, sigla) values ('Cadastro de Pessoa Física', 'CPF');
insert into tb_tipo_documento (nome, sigla) values ('Registro Geral', 'RG');
insert into tb_tipo_documento (nome, sigla) values ('Carteira Nacional de Habilitação', 'CNH');
insert into tb_tipo_documento (nome, sigla) values ('Título de Eleitor', 'TE');
insert into tb_tipo_documento (nome, sigla) values ('Carteira de Trabalho e Previdência Social', 'CTPS');
insert into tb_tipo_documento (nome, sigla) values ('Passaporte', 'PASSAPORTE');
insert into tb_tipo_documento (nome, sigla) values ('Certidão de Nascimento', 'CN');
insert into tb_tipo_documento (nome, sigla) values ('Certidão de Casamento', 'CC');
insert into tb_tipo_documento (nome, sigla) values ('Documento Nacional de Identificação', 'DNI');
insert into tb_tipo_documento (nome, sigla) values ('Cadastro Nacional da Pessoa Jurídica', 'CNPJ');
insert into tb_tipo_documento (nome, sigla) values ('Inscrição Estadual', 'IE');
insert into tb_tipo_documento (nome, sigla) values ('Inscrição Municipal', 'IM');
insert into tb_tipo_documento (nome, sigla) values ('Contrato Social', 'CS');
insert into tb_tipo_documento (nome, sigla) values ('Microempreendedor Individual', 'MEI');