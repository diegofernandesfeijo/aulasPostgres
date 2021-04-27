Conceitos e Melhores Praticas 
CTE (Common Table Expretion)

CRIAR BLOCOS DE CÓDIGOS PARA CRIAR UMA NOVA TABELA 

SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;

--exemplo simples de uma criação de temporaria WITH + tmp + AS + SELECT
WITH tbl_tmp_banco AS (
	SELECT numero, nome FROM banco
)
SELECT numero, nome FROM tbl_tmp_banco
--criou a temporária tbl_tmp_banco com os campos numero, nome
------------------------------------------

--outro exemplo um pouco mais complexto 
WITH params AS (
	SELECT 213 AS banco_numero  --tabela params campo banco_numero = 213
), tbl_tmp_banco AS (  --continua a definição colocando uma , depois do primeiro )
	SELECT numero, nome FROM banco
	JOIN params ON params.banco_numero = banco.numero --JOIN entre os campos 
)
--SELECT banco_numero FROM params; --primeiro tmp manual
--SELECT numero, nome FROM tbl_tmp_banco; --ultimo tmp com resultado dos joins
