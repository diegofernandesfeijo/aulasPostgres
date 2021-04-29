--VIEWS
--É POSSÍVEL EFETUAR (SELECT) E (INSERT,UPDATE,DELETE) SE A VIEW NÃO TIVER JOINS, OU SEJA,
--QUE TENHA SOMENTE UMA CONSULTA DIRETA, CASO TENHA JOINS, SÓ SERA POSSÍVEL O SELECT.
--POIS ELA É UM "TUNEL" PARA A TABELA, LOGO QUANDO HOUVER ESTES UPDATES,INSERTS OU DELETS
--MESMO SENDO NA VIEW, SERA APLICADO NA TABELA.

--SINTAX
-- SIMPLES BUSCA OS MESMOS CAMPOS QUE ESTÃO NA TABELA
CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT * FROM vw_bancos
--------------------------
--CRIANDO OS PRÓPRIOS NOMES DAS COLUNAS DA VIEW
CREATE OR REPLACE VIEW vw_bancos2 (banco_numero, banco_nome, banco_ativo ) AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT * FROM vw_bancos2
----------------------------
--TESTE INSERINDO DIRETO NA VIEW
INSERT INTO vw_bancos2 (banco_numero, banco_nome, banco_ativo) 
VALUES (51, 'TESTE', TRUE);

--VISTO QUE INSERINDO NA VIEW, SALVOU DIRETO NA TABELA, USOU A VIEW COMO "ATALHO"
SELECT * FROM banco WHERE numero = 51 AND nome = 'TESTE' AND ativo = TRUE;

--------------------------
--CRIANDO UMA VIEW TEMPORARY
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome FROM agencia
);

--ESSA VIEW TEMPORARY SÓ IRA FUNCIONAR NA QUERY ABERTA, E TENTAR USAR EM OUTRA ELA NAO EXISTIRÁ.
--------------------------

---VIEW COM LOCAL CHECK OPTION (VALIDA UMA CONDIÇÃO DENTRO DA VIEW)
---CASO ESSA CONDIÇÃO NAO SEJA VALIDA, RETORNA ERRO EM UM INSERT, UPDATE, DELETE, EXEMPLO

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION; --só ira aceitar alterações na view nessa condição

INSERT INTO vw_bancos_ativos (numero, nome, ativo) VALUES (56, 'teste', FALSE);
--IRA GERAR O ERRO "ERROR:  new row violates check option for view "vw_bancos_ativos""
--pois geramos uma codição WHERE ativo IS TRUE e estamos inserindo na VIEW um FALSE.

------------------------
--AQUI ESTAMOS CRIANDO UMA VIEW COM WITH LOCAL BUSCANDO OUTRA VIEW COM WITH LOCAL

CREATE OR REPLACE VIEW vw_bancos_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos --valida a primeira view vw_bancos_ativos só aceita ativo = TRUE
	WHERE nome ILIKE 'a%' --só ira aceitar nome com A ou a e continuação.
) WITH LOCAL CHECK OPTION; --só ira aceitar alterações na view nessa condição

INSERT INTO vw_bancos_bancos_com_a (numero, nome, ativo) VALUES (56, 'teste', FALSE);
--ira trazer o erro da primeira view (ERROR:  new row violates check option for view "vw_bancos_ativos")

INSERT INTO vw_bancos_bancos_com_a (numero, nome, ativo) VALUES (56, 'Beste', TRUE);
--Aqui ele validou o TRUE do ativo e ira trazer o erro da segunda view (ERROR:  new row violates check option for view "vw_bancos_bancos_com_a")

-----------------------------------------------------------------------------------------------------
--AGORA DIGAMOS QUE NA MESMA LOGICA ACIMA, TEMOS A PRIMEIRA VIEW SEM O WITH LOCAL CHECK OPTION MAS TEM UMA VALIDAÇÃO ALI

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
);

INSERT INTO vw_bancos_ativos (numero, nome, ativo) VALUES (56, 'teste', FALSE);
--NAO VALIDA NADA E ACEITA INSERT

-----------------------------------------------
--MAS AGORA VAMOS CRIAR A SEGUNDA VIEW COM 'WITH CASCADED CHECK OPTION'

CREATE OR REPLACE VIEW vw_bancos_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos --valida a primeira view vw_bancos_ativos só aceita ativo = TRUE
	WHERE nome ILIKE 'a%' --só ira aceitar nome com A ou a e continuação.
) WITH CASCADED CHECK OPTION; --só ira aceitar alterações na view nessa condição

--MESMO NAO EXISTINDO UMA VALIDAÇÃO NA PRIMEIRA VIEW, COM A OPÇÃO CASCADED ELE FORÇA ESSA VALIDAÇÃO PARA DEPOIS CONTINUAR PARA SEGUNDA VIEW

INSERT INTO vw_bancos_bancos_com_a (numero, nome, ativo) VALUES (56, 'teste', FALSE);
--ira trazer o erro da primeira view (ERROR:  new row violates check option for view "vw_bancos_ativos")
INSERT INTO vw_bancos_bancos_com_a (numero, nome, ativo) VALUES (56, 'Beste', TRUE);
--Aqui ele validou o TRUE do ativo e ira trazer o erro da segunda view (ERROR:  new row violates check option for view "vw_bancos_bancos_com_a")

-------------------------------------------------------
