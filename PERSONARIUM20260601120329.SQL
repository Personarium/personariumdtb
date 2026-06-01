/*
	Sistema: 		Personarium: Sistema de Gestão de Pessoas
    Objetivo:       Inserir novo campo
    Funcionalidade: Gerenciamento de Pessoas e Documentos
    Data: 			01/06/2026
    Demanda: 		PERSONARIUM20260601120329
*/

alter table tb_pessoa add column if not exists data_nascimento date null;