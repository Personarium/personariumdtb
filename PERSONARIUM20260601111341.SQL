/*
	Sistema: 		Personarium: Sistema de Gestão de Pessoas
    Objetivo:       Criar tabelas e relacionamentos
    Funcionalidade: Gerenciamento de Pessoas e Documentos
    Data: 			01/06/2026
    Demanda: 		PERSONARIUM20260601111341
*/

drop table if exists tb_tipo_documento cascade;
drop table if exists tb_documento cascade;
drop table if exists tb_tipo_pessoa cascade;
drop table if exists tb_pessoa cascade;
drop table if exists tb_pessoa_documento cascade;

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

create index in_documento_numero on tb_documento(numero);

create index in_pessoa_nome on tb_pessoa(nome);