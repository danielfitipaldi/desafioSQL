-- VIEW QUE RETORNA ID, NOME, DATA DE NASCIMENTO E IDADE DE TODAS AS PESSOAS VINCULADAS À ACADEMIA
CREATE VIEW VW_IDADE AS
SELECT ID_PESSOA, 
	   NOME, 
	   SOBRENOME, 
	   DTNASC, 
	   DBO.FN_CALCULAR_IDADE(DTNASC) AS IDADE 
	   FROM PESSOA

--TESTANDO
SELECT * FROM VW_IDADE

-- VIEW DADOS DE ALUNOS COM MATRÍCULAS ATIVAS
CREATE VIEW VW_DADOS_ALUNOS

AS

SELECT A.ID_ALUNO, 
	   P.NOME, 
	   P.SOBRENOME, 
	   P.SEXO, 
	   DBO.FN_CALCULAR_IDADE(P.DTNASC) AS IDADE, 
	   A.DT_MATRICULA, 
	   A.PESO, 
	   A.ALTURA 
	   FROM ALUNO A

INNER JOIN PESSOA P
	   ON P.ID_PESSOA = A.FK_PESSOA_ID_PESSOA
	   WHERE DT_TRANCAMENTO IS NULL

SELECT * FROM VW_DADOS_ALUNOS

-- VIEW QUE RETORNA A QUANTIDADE DE ALUNOS MATRICULADOS POR TURMA
CREATE VIEW vw_matricula_aluno_turma
AS
  SELECT A.nome,
         T.horario,
         T.duracao,
         T.data_inicial,
         T.data_final,
         Count(M.fk_turma_id_turma) AS TOTAL_ALUNOS_TURMA
  FROM   turma T
         INNER JOIN atividade A
                 ON A.id_atividade = T.fk_atividade_id_atividade
         INNER JOIN matricula M
                 ON T.id_turma = M.fk_turma_id_turma
  GROUP  BY A.nome,
            T.horario,
            T.duracao,
            T.data_inicial,
            T.data_final 


-- TESTANDO
SELECT * FROM VW_MATRICULA_ALUNO_TURMA


-- QUADRO DE HORÁRIOS COM ATIVIDADE/TURMA/INSTRUTOR
CREATE VIEW vw_turma_atividade_instrutor
AS
  SELECT T.id_turma,
         A.nome AS ATIVIDADE,
         T.horario,
         T.duracao,
         T.data_inicial,
         T.data_final,
         P.nome,
         P.sobrenome
  FROM   turma T
         RIGHT JOIN atividade A
                 ON T.fk_atividade_id_atividade = A.id_atividade
         LEFT JOIN instrutor I
                ON I.num_inscricao = T.fk_instrutor_num_inscricao
         LEFT JOIN pessoa P
                ON P.id_pessoa = I.fk_pessoa_id_pessoa 

-- TESTANDO
SELECT * FROM VW_TURMA_ATIVIDADE_INSTRUTOR

-- VIEW PARA CONTROLE DE PRESENÇA NAS AULAS
CREATE VIEW vw_dados_presenca
AS
SELECT P.nome,
       P.sobrenome,
       ATI.nome								AS ATIVIDADE,
       CON.data_aula,
       dbo.Fn_status_presenca(CON.presente) AS PRESENCA
FROM   (SELECT M.fk_turma_id_turma,
               M.fk_aluno_id_aluno,
               PR.data_aula,
               PR.presente,
               TU.fk_atividade_id_atividade,
               AL.fk_pessoa_id_pessoa
        FROM   matricula M
               INNER JOIN presenca PR
                       ON M.id_matricula = PR.fk_matricula_id_matricula
               INNER JOIN turma TU
                       ON TU.id_turma = M.fk_turma_id_turma
               INNER JOIN aluno AL
                       ON AL.id_aluno = M.fk_aluno_id_aluno) CON
       INNER JOIN pessoa P
               ON P.id_pessoa = CON.fk_pessoa_id_pessoa
       INNER JOIN atividade ATI
               ON ATI.id_atividade = CON.fk_atividade_id_atividade 
-- TESTANDO
SELECT * FROM VW_DADOS_PRESENCA

