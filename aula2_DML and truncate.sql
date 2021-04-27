                    DML - CRUD

- CONDIÇÕES

SELECT 

=

> / >=
< / <=
<> / !=
LIKE
ILIKE
IN

- IDEMPOTÊNCIA (SELECT)
EXISTS
NOT EXISTS

<recomendado usar>
JOIN

-------------

INSERT

IDEMPOTÊNCIA (INSERT)
EXISTS
NOT EXISTS
<recomendado usar>

ON CONFLICT 
como usar:
digamos que temos uma tabela "agencia" com PK (banco, agencia)
INSERT INTO agencia (banco, agenda, nome) values (3,1,'Itau') ON CONFLICT (banco, agenda) DO NOTHING;
sempre completar com (ON CONFLICT + PK + DO NOTHING;)
caso ocorra algum conflito de PK nao faz nada.

--------------

TRUNCATE

TRUNCATE TABLE ONLY + TABELA (E MAIS QUATRO POSSSIBILIDADES)

[RESTART IDENTITY OU CONTINUE IDENTITY]
O RESTART IDENTITY ira zerar o campo ID (SERIAL "auto increment") e começará do id 0;
O CONTINUE IDENTITY ira manter o ultimo id gravado e +1 para o novo dado adicionado após a limpeza da tabela;

[CASCADE OU RESTRICT]
O RESTRICT é o padrão, caso tenha FK ele não deixa dar TRUNCATE;
O CASCADE caso use, ele ira dar TRUNCATE na tabela e se houver FK ela ira apagar a referencia delas em outras tabelas;

-------------

SELECT numero, nome, ativo FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM CLIENTE;
SELECT id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, numero, cliente_numero FROM conta_corrente;
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

------------

/*CREATE TABLE IF NOT EXISTS teste (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	--CURRENT_TIMESTAMP = hora atual
);*/

/*DROP TABLE IF EXISTS teste;*/

/*CREATE TABLE IF NOT EXISTS teste (
	cpf VARCHAR (11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (cpf)
);*/

/*INSERT INTO teste (cpf, nome, created_at)
VALUES ('22344566712', 'Zé Colmeia', '2021-04-26 23:30:00');*/
--se tentar rodar 2x gera o erro de PK - ok, melhor pratica abaixo

/*INSERT INTO teste (cpf, nome, created_at)
VALUES ('22344566712', 'Zé Colmeia', '2021-04-26 23:30:00')
ON CONFLICT (cpf) DO NOTHING;*/
--se houver conflito (cpf) nao faça nada


