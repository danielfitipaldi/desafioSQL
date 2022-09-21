-- BUSCA DE REGISTROS NAS ENTIDADES ALUNO E INSTRUTOR
CREATE PROCEDURE Usp_busca_tipo_pessoa @ENTIDADE AS VARCHAR(15)
AS
  BEGIN
      IF @ENTIDADE = 'ALUNO'
        SELECT P.nome,
               P.sobrenome,
               P.sexo,
               A.telefone,
               A.dt_matricula,
               A.dt_trancamento,
               A.fk_turma_id_turma AS TURMA_MONITOR
        FROM   aluno A
               INNER JOIN pessoa P
                       ON A.fk_pessoa_id_pessoa = P.id_pessoa
      ELSE IF @ENTIDADE = 'INSTRUTOR'
        SELECT P.nome,
               P.sobrenome,
               P.sexo,
               Concat(T.ddd, T.numero) AS TELEFONE,
               I.dt_admissao,
               I.dt_demissao
        FROM   instrutor I
               INNER JOIN telefone T
                       ON T.fk_instrutor_num_inscricao = I.num_inscricao
               INNER JOIN pessoa P
                       ON I.fk_pessoa_id_pessoa = P.id_pessoa
      ELSE
        PRINT 'ENTIDADE NÃO LISTADA'
  END 

--TESTANDO
EXEC uSP_BUSCA_TIPO_PESSOA @ENTIDADE = 'ALUNO'
EXEC uSP_BUSCA_TIPO_PESSOA @ENTIDADE = 'INSTRUTOR'
EXEC uSP_BUSCA_TIPO_PESSOA @ENTIDADE = 'PROFESSOR'



-- BUSCA DE DADOS CADASTRAIS POR NOME EM ALUNOS
CREATE PROCEDURE Usp_aluno_busca_por_nome @NOME      AS VARCHAR(20),
                                          @SOBRENOME AS VARCHAR(20) = NULL
AS
  BEGIN
      IF @SOBRENOME IS NULL
        SELECT P.nome,
               P.sobrenome,
               A.telefone,
               E.rua,
               E.bairro,
               E.cidade,
               E.estado,
               A.dt_matricula,
               A.dt_trancamento
        FROM   aluno A
               INNER JOIN pessoa P
                       ON A.fk_pessoa_id_pessoa = P.id_pessoa
               LEFT JOIN endereco E
                      ON E.fk_pessoa_id_pessoa = P.id_pessoa
        WHERE  nome LIKE + '%' + @NOME + '%'
      ELSE
        SELECT P.nome,
               P.sobrenome,
               A.telefone,
               E.rua,
               E.bairro,
               E.cidade,
               E.estado,
               A.dt_matricula,
               A.dt_trancamento
        FROM   aluno A
               INNER JOIN pessoa P
                       ON A.fk_pessoa_id_pessoa = P.id_pessoa
               LEFT JOIN endereco E
                      ON E.fk_pessoa_id_pessoa = P.id_pessoa
        WHERE  nome LIKE + '%' + @NOME + '%'
               AND sobrenome LIKE + '%' + @SOBRENOME + '%'
  END 
-- TESTANDO
EXEC uSP_ALUNO_BUSCA_POR_NOME @NOME = 'DAN', @SOBRENOME = 'SILVA'

-- BUSCA DE DADOS CADASTRAIS DE FUNCIONÁRIOS POR NOME
CREATE PROCEDURE Usp_funcionario_busca_por_nome @NOME      AS VARCHAR(20),
                                                @SOBRENOME AS VARCHAR(20) = NULL
AS
  BEGIN
      IF @SOBRENOME IS NULL
        SELECT P.nome,
               P.sobrenome,
               P.sexo,
               E.rua,
               E.bairro,
               E.cidade,
               E.estado,
               I.dt_admissao,
               I.dt_demissao
        FROM   pessoa P
               INNER JOIN instrutor I
                       ON P.id_pessoa = I.fk_pessoa_id_pessoa
               INNER JOIN endereco E
                       ON P.id_pessoa = E.fk_pessoa_id_pessoa
        WHERE  nome LIKE + '%' + @NOME + '%'
      ELSE
        SELECT P.nome,
               P.sobrenome,
               A.telefone,
               E.rua,
               E.bairro,
               E.cidade,
               E.estado,
               A.dt_matricula,
               A.dt_trancamento
        FROM   aluno A
               INNER JOIN pessoa P
                       ON A.fk_pessoa_id_pessoa = P.id_pessoa
               INNER JOIN endereco E
                       ON E.fk_pessoa_id_pessoa = P.id_pessoa
        WHERE  nome LIKE + '%' + @NOME + '%'
               AND sobrenome LIKE + '%' + @SOBRENOME + '%'
  END 

-- TESTANDO
EXEC uSP_FUNCIONARIO_BUSCA_POR_NOME @NOME = 'FÁBIO'


-- INSERINDO ALUNO E MATRICULANDO EM UMA TURMA
CREATE OR ALTER PROCEDURE uSP_INSERT_ALUNO 
@DT_MATRICULA			DATE,
@DT_TRANCAMENTO			DATE, 
@PESO					DECIMAL, 
@ALTURA					DECIMAL, 
@TELEFONE				CHAR(11), 
@FK_PESSOA_ID_PESSOA	INT, 
@FK_TURMA_ID_TURMA		INT = NULL, 
@ID						INT = NULL, 
@TURMA_ID				INT

AS 

BEGIN
	INSERT INTO ALUNO (DT_MATRICULA, DT_TRANCAMENTO, 
	PESO, ALTURA, TELEFONE, FK_PESSOA_ID_PESSOA, 
	FK_TURMA_ID_TURMA)
	VALUES (@DT_MATRICULA, @DT_TRANCAMENTO, @PESO, 
	@ALTURA, @TELEFONE, @FK_PESSOA_ID_PESSOA, 
	@FK_TURMA_ID_TURMA)

	SELECT @ID = SCOPE_IDENTITY()
	INSERT INTO MATRICULA(FK_ALUNO_ID_ALUNO, FK_TURMA_ID_TURMA)
	VALUES (@ID, @TURMA_ID)
	
END

-- TESTANDO

EXEC uSP_INSERT_ALUNO  @DT_MATRICULA = '2021-02-17', @DT_TRANCAMENTO = NULL,  @PESO = 60.2, 
@ALTURA = 1.76, @TELEFONE = '81974328996', @FK_PESSOA_ID_PESSOA = 75, @FK_TURMA_ID_TURMA = NULL, 
@TURMA_ID = 2


-- BUSCA DE ALUNO POR DATA DE MATRÍCULA
CREATE PROCEDURE uSP_BUSCA_DATAS (@DATA1 AS DATE, @DATA2 AS DATE = NULL) 
AS 
BEGIN

IF @DATA2 IS NULL
SELECT * 
FROM ALUNO
WHERE DT_TRANCAMENTO IS NULL AND DT_MATRICULA <= @DATA1

ELSE
SELECT * 
FROM ALUNO
WHERE DT_MATRICULA BETWEEN @DATA1 AND @DATA2

END

--TESTANDO
EXEC uSP_BUSCA_DATAS '2020-08-30', '2022-02-28'

