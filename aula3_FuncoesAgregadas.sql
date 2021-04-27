FUNÇÕES AGREGADAS (Aggregate Functions)
algumas funções

AVG
COUNT (HAVING)
MAX
MIN
SUM

--SELECIONAR TODOS CAMPOS DA TABELA
--SELECT * FROM information_schema.columns WHERE table_name = 'banco';

--AVG (informa a média dos valores)
SELECT AVG
	(valor) 
FROM 
	cliente_transacoes;

--COUNT (HAVING)
SELECT COUNT 
	(numero) 
FROM 
	cliente;
-------------------------------------------
SELECT COUNT 
	(numero), 
	email 
FROM 
	cliente
WHERE 
	email
ILIKE 
	'%gmail.com'
GROUP BY email;
-------------------------------------------
SELECT COUNT (id), tipo_transacao_id FROM cliente_transacoes
GROUP BY tipo_transacao_id HAVING COUNT (id) > 150;
--HAVING COUNT para contar e trazer somente o que estiver com mias de 150 transacoes;

	
--MAX
SELECT MAX 
	(numero)
FROM
	cliente;

--MIN
SELECT MIN 
	(numero)
FROM
	cliente;

--SUM
SELECT SUM (valor)
FROM cliente_transacoes;


--OBS: Sempre usar o GROUP BY em consultas de agrupamento ex.: (COUNT, MAX, MIN)
