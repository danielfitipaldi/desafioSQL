-- Queries simples e com where

-- total de alunos matriculados até o início do lockdown 15/03/2020
SELECT Count(0) AS TOTAL_ALUNOS_MATRICULADOS
FROM   aluno
WHERE  dt_matricula < '2020-03-14'
       AND ( dt_trancamento IS NULL
              OR dt_trancamento > '2020-03-14' )

-- total de alunos no período mais grave da pandemia - 1 onda (mar/20 à set/20)
SELECT Count(0) AS TOTAL_ALUNOS_MATRICULADOS
FROM   aluno
WHERE  dt_trancamento IS NULL
       AND dt_matricula < '2020-08-30' 

-- Utilizando a procedure que busca datas de alunos matriculados e o rowcount para fazer o cálculo do total
EXEC uSP_BUSCA_DATAS '2020-03-14'
SELECT @@ROWCOUNT AS TOTAL

-- Número de novas matrículas após melhora no número de casos e abertura do gov 01/09/2020 até nova piora 10/01/2021
SELECT COUNT(0) AS NOVAS_MATRICULAS
FROM   ALUNO
WHERE (DT_MATRICULA BETWEEN '01/09/2020' AND '2021-01-10')

-- Utilizando a procedure para mostrar quem são esses novos alunos 
EXEC uSP_BUSCA_DATAS '01/09/2020', '2021-01-10'

-- total de alunos matriculados após melhora no número de casos e abertura do gov 01/09/2020 até nova piora 10/01/2021
-- Soma de novas matrículas com alunos que estavam matriculados antes desse período
SELECT Count(0) AS TOTAL_ATE_JAN_21
FROM   aluno
WHERE  ( dt_matricula BETWEEN '01/09/2020' AND '2021-01-10' )
        OR ( dt_matricula <= '2021-01-10'
             AND dt_trancamento IS NULL ) 

-- ALUNOS QUE TRANCARAM APÓS SEGUNDA PIORA NA PANDEMIA
SELECT * FROM ALUNO
WHERE DT_TRANCAMENTO >= '2021-01-10'

-- total de alunos matriculados atualmente
SELECT COUNT(0) AS TOTAL_ALUNOS
FROM   ALUNO
WHERE  DT_TRANCAMENTO IS NULL

-- Total de instrutores ativos antes do início da pandemia (2020)
SELECT Count(0) AS TOTAL_INSTRUTORES
FROM   instrutor
WHERE  dt_admissao < '2020-03-14'
       AND ( dt_demissao IS NULL
              OR dt_demissao > '2020-03-14' ) 

-- INSTRUTORES DEMITIDOS DURANTE PRIMEIRA ONDA DA PANDEMIA
SELECT *
FROM   instrutor
WHERE  Month(dt_demissao) BETWEEN '3' AND '8'
       AND Year(dt_demissao) = '2020' 

-- Instrutores contratados após período de melhora na pandemia
SELECT *
FROM  INSTRUTOR
WHERE DT_ADMISSAO >= '2020-09-01'

-- Instrutores ativos na academia
SELECT * 
FROM  INSTRUTOR
WHERE DT_DEMISSAO IS NULL

-- 5 Idades com mais pessoas vinculadas à academia
SELECT TOP 5 idade,
             Count(0) AS TOTAL_IDADE
FROM   vw_idade
GROUP  BY idade
ORDER  BY total_idade DESC 

-- ALUNOS IDOSOS 
SELECT * 
FROM   PESSOA
WHERE  YEAR(DTNASC) < 1962

-- Classificação por grupos etários
SELECT CPI.classificacao_por_idade,
       Count(0) TOTAL
FROM   (SELECT idade,
               CASE
                 WHEN idade BETWEEN 17 AND 23 THEN 'JOVEM'
                 WHEN idade BETWEEN 24 AND 40 THEN 'JOVEM ADULTO'
				 WHEN idade BETWEEN 41 AND 60 THEN 'ADULTO' 
                 WHEN idade > 60 THEN 'IDOSO'
               END CLASSIFICACAO_POR_IDADE
        FROM   VW_DADOS_ALUNOS) CPI
GROUP  BY CPI.classificacao_por_idade
ORDER  BY total DESC


-- Total de matrículas por mês (Meses em que os alunos mais se matriculam)
SELECT MONTH(DT_MATRICULA) AS MES,
	   COUNT(0) AS TOTAL_MATRICULAS
FROM ALUNO
GROUP BY MONTH(DT_MATRICULA)
ORDER BY TOTAL_MATRICULAS DESC

-- MAIOR NUMÉRO DE MATRÍCULAS POR MÊS EM CADA ANO ( 5 MELHORES RESULTADOS )
SELECT TOP 5 DATENAME(MONTH, DT_MATRICULA) MES, 
	   YEAR(DT_MATRICULA) ANO, 
	   COUNT(MONTH(DT_MATRICULA)) TOTAL_MES 
FROM ALUNO
GROUP BY YEAR(DT_MATRICULA), 
		 DATENAME(MONTH, DT_MATRICULA)
ORDER BY TOTAL_MES DESC

-- TOTAL DE MATRÍCULAS EM CADA ANO
SELECT YEAR(DT_MATRICULA) ANO, 
	   COUNT(0) TOTAL_MATRICULAS
FROM ALUNO
GROUP BY YEAR(DT_MATRICULA)
ORDER BY ANO

-- TRANCAMENTOS POR MES
SELECT MONTH(DT_TRANCAMENTO) AS MES,
	   COUNT(0) AS TOTAL_TRANCAMENTOS
FROM ALUNO
WHERE DT_TRANCAMENTO IS NOT NULL
GROUP BY MONTH(DT_TRANCAMENTO)
ORDER BY TOTAL_TRANCAMENTOS DESC

-- TOTAL ALUNOS E INSTRUTORES, VINCULADOS OU NÃO, POR BAIRRO
SELECT BAIRRO, 
	   COUNT(BAIRRO) AS TOTAL 
FROM   ENDERECO
GROUP BY BAIRRO
ORDER BY TOTAL DESC

-- TOTAL ALUNOS E INSTRUTORES, VINCULADOS OU NÃO, POR CIDADE
SELECT CIDADE, 
	   COUNT(CIDADE) AS TOTAL 
FROM   ENDERECO
GROUP BY CIDADE
ORDER BY TOTAL DESC










