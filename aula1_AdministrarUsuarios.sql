--criando uma role e gerando algumas permissões
--CREATE ROLE professores NOCREATEDB NOCREATEROLE INHERIT NOLOGIN NOBYPASSRLS CONNECTION LIMIT 10;

--alterando configuração da role
--ALTER ROLE professores PASSWORD '123';

--veriifcar roles do pg_admin
--SELECT * FROM pg_roles

--dropando uma role
--DROP ROLE diego;

--adicionando uma role nova com suas confurações dentro de outra roule (ex. Alunos dentro role Escola)
--CREATE ROLE diego PASSWORD '123' IN ROLE professores;

--criando uma tabela simples
--CREATE TABLE teste (nome varchar (10));


--adicionando todos os previlégios na tabela para grupo professores
--GRANT ALL ON TABLE teste to professores;

--comando abaixo estou criando a role diego e 'inherit' herdando tudo da roule professores, inclusive as permissões GRANT
--CREATE ROLE diego INHERIT LOGIN PASSWORD '123' IN ROLE professores;

--retira as permissões que estão na professores de diego
--REVOKE professores FROM diego;