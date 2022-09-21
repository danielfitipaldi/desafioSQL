/* SCALAR FUNCTIONS */

-- FUNCAO QUE ATRIBUI ATIVIDADE OU FINALIZAÇÃO PARA AS MATRICULAS DOS ALUNOS OU CONTRATO DOS PROFESSORES
CREATE FUNCTION FN_STATUS_ATIVO (@ATIVO AS VARCHAR(15)) RETURNS VARCHAR(15)
AS 
BEGIN

	IF @ATIVO IS NULL
		SELECT @ATIVO = 'ATIVO(A)'

	ELSE
		SELECT @ATIVO = 'FINALIZADO(A)'

	RETURN @ATIVO
END

-- TESTANDO

SELECT id_aluno,
       dt_matricula,
       dt_trancamento,
       dbo.Fn_status_ativo(dt_trancamento) AS STATUS_ALUNO
FROM   aluno 

SELECT *,
       dbo.Fn_status_ativo(dt_demissao) AS STATUS_INSTRUTOR
FROM   instrutor 


-- FUNCAO QUE ATRIBUI OS VALORES PRESENTE E AUSENTE DE ACORDO COM A FREQUÊNCIA DOS ALUNOS
CREATE FUNCTION FN_STATUS_PRESENCA(@VALOR BIT) RETURNS VARCHAR(10)
AS
BEGIN 
	DECLARE @PRESENTE VARCHAR(10)

	IF @VALOR = 0
		SELECT @PRESENTE = 'AUSENTE'

	IF @VALOR = 1
		SELECT @PRESENTE = 'PRESENTE'

	RETURN @PRESENTE
END

-- TESTANDO
SELECT *,
       dbo.Fn_status_presenca(presente) AS STATUS_PRESENCA
FROM   presenca 

-- FUNCAO QUE CALCULA A IDADE A PARTIR DA DATA DE NASCIMENTO
CREATE FUNCTION Fn_calcular_idade(@DTNASC DATE)
returns INT
AS
  BEGIN
      RETURN Datediff(year, @DTNASC, Getdate())
  END 

/* TABLE FUNCTIONS */

-- FUNÇÃO QUE RETORNA UMA TABELA COM OS DADOS DE TODOS OS ALUNOS MATRICULADOS EM DETERMINADO ANO
CREATE FUNCTION Fn_matriculas_por_ano (@ANO VARCHAR(4))
returns TABLE
AS
    RETURN
      (SELECT P.nome,
              P.sobrenome,
              dbo.Fn_calcular_idade(P.dtnasc) AS IDADE,
              P.sexo,
              A.telefone,
              A.altura,
              A.peso,
              A.dt_matricula
       FROM   aluno A
              INNER JOIN pessoa P
                      ON A.fk_pessoa_id_pessoa = P.id_pessoa
       WHERE  Year(dt_matricula) = @ANO) 

-- TESTANDO
SELECT * FROM DBO.FN_MATRICULAS_POR_ANO('2019')

--  FUNÇÃO QUE RETORNA UMA TABELA COM OS DADOS DE TODOS OS ALUNOS QUE TRANCARAM A MATRÍCULA EM DETERMINADO MES DO ANO
CREATE FUNCTION Fn_trancamento_por_mes (@ANO VARCHAR(4),
                                        @MES VARCHAR(2))
returns TABLE
AS
    RETURN
      (SELECT P.nome,
              P.sobrenome,
              dbo.Fn_calcular_idade(P.dtnasc) AS IDADE,
              P.sexo,
              A.telefone,
              A.altura,
              A.peso,
              A.dt_trancamento
       FROM   aluno A
              INNER JOIN pessoa P
                      ON A.fk_pessoa_id_pessoa = P.id_pessoa
       WHERE  Year(dt_trancamento) = @ANO
              AND Month(dt_trancamento) = @MES) 
-- TESTANDO
SELECT * FROM DBO.FN_TRANCAMENTO_POR_MES('2020', '03')
