-- Queries simples e com where

-- total de alunos matriculados at� o in�cio do lockdown 15/03/2020
SELECT Count(0) AS TOTAL_ALUNOS_MATRICULADOS
FROM   aluno
WHERE  dt_matricula < '2020-03-14'
       AND ( dt_trancamento IS NULL
              OR dt_trancamento > '2020-03-14' )

-- total de alunos no per�odo mais grave da pandemia - 1 onda (mar/20 � set/20)
SELECT Count(0) AS TOTAL_ALUNOS_MATRICULADOS
FROM   aluno
WHERE  dt_trancamento IS NULL
       AND dt_matricula < '2020-08-30' 

-- Utilizando a procedure que busca datas de alunos matriculados e o rowcount para fazer o c�lculo do total
EXEC uSP_BUSCA_DATAS '2020-03-14'
SELECT @@ROWCOUNT AS TOTAL

-- N�mero de novas matr�culas ap�s melhora no n�mero de casos e abertura do gov 01/09/2020 at� nova piora 10/01/2021
SELECT COUNT(0) AS NOVAS_MATRICULAS
FROM   ALUNO
WHERE (DT_MATRICULA BETWEEN '01/09/2020' AND '2021-01-10')

-- Utilizando a procedure para mostrar quem s�o esses novos alunos 
EXEC uSP_BUSCA_DATAS '01/09/2020', '2021-01-10'

-- total de alunos matriculados ap�s melhora no n�mero de casos e abertura do gov 01/09/2020 at� nova piora 10/01/2021
-- Soma de novas matr�culas com alunos que estavam matriculados antes desse per�odo
SELECT Count(0) AS TOTAL_ATE_JAN_21
FROM   aluno
WHERE  ( dt_matricula BETWEEN '01/09/2020' AND '2021-01-10' )
        OR ( dt_matricula <= '2021-01-10'
             AND dt_trancamento IS NULL ) 

-- ALUNOS QUE TRANCARAM AP�S SEGUNDA PIORA NA PANDEMIA
SELECT * FROM ALUNO
WHERE DT_TRANCAMENTO >= '2021-01-10'

-- total de alunos matriculados atualmente
SELECT COUNT(0) AS TOTAL_ALUNOS
FROM   ALUNO
WHERE  DT_TRANCAMENTO IS NULL

-- Total de instrutores ativos antes do in�cio da pandemia (2020)
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

-- Instrutores contratados ap�s per�odo de melhora na pandemia
SELECT *
FROM  INSTRUTOR
WHERE DT_ADMISSAO >= '2020-09-01'

-- Instrutores ativos na academia
SELECT * 
FROM  INSTRUTOR
WHERE DT_DEMISSAO IS NULL

-- 5 Idades com mais pessoas vinculadas � academia
SELECT TOP 5 idade,
             Count(0) AS TOTAL_IDADE
FROM   vw_idade
GROUP  BY idade
ORDER  BY total_idade DESC 

-- ALUNOS IDOSOS 
SELECT * 
FROM   PESSOA
WHERE  YEAR(DTNASC) < 1962

-- Classifica��o por grupos et�rios
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


-- Total de matr�culas por m�s (Meses em que os alunos mais se matriculam)
SELECT MONTH(DT_MATRICULA) AS MES,
	   COUNT(0) AS TOTAL_MATRICULAS
FROM ALUNO
GROUP BY MONTH(DT_MATRICULA)
ORDER BY TOTAL_MATRICULAS DESC

-- MAIOR NUM�RO DE MATR�CULAS POR M�S EM CADA ANO ( 5 MELHORES RESULTADOS )
SELECT TOP 5 DATENAME(MONTH, DT_MATRICULA) MES, 
	   YEAR(DT_MATRICULA) ANO, 
	   COUNT(MONTH(DT_MATRICULA)) TOTAL_MES 
FROM ALUNO
GROUP BY YEAR(DT_MATRICULA), 
		 DATENAME(MONTH, DT_MATRICULA)
ORDER BY TOTAL_MES DESC

-- TOTAL DE MATR�CULAS EM CADA ANO
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

-- TOTAL ALUNOS E INSTRUTORES, VINCULADOS OU N�O, POR BAIRRO
SELECT BAIRRO, 
	   COUNT(BAIRRO) AS TOTAL 
FROM   ENDERECO
GROUP BY BAIRRO
ORDER BY TOTAL DESC

-- TOTAL ALUNOS E INSTRUTORES, VINCULADOS OU N�O, POR CIDADE
SELECT CIDADE, 
	   COUNT(CIDADE) AS TOTAL 
FROM   ENDERECO
GROUP BY CIDADE
ORDER BY TOTAL DESC










