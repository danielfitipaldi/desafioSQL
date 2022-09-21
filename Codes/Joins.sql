-- CONSULTAS COM JOIN

-- TOTAL DE MATRICULAS POR ALUNO
SELECT P.nome,
       P.sobrenome,
       Count(M.fk_aluno_id_aluno) TOTAL_MATRICULAS
FROM   aluno A
       INNER JOIN matricula M
               ON A.id_aluno = M.fk_aluno_id_aluno
       INNER JOIN pessoa P
               ON A.fk_pessoa_id_pessoa = P.id_pessoa
GROUP  BY P.nome,
          P.sobrenome,
          A.fk_pessoa_id_pessoa
ORDER  BY TOTAL_MATRICULAS DESC 

-- Dados dos instrutores ativos na academia, ordenados pela data de admissão
SELECT P.nome,
       P.sobrenome,
       P.sexo,
       INS.titulacao,
       INS.dt_admissao
FROM   pessoa P
       INNER JOIN instrutor INS
               ON ( P.id_pessoa = INS.fk_pessoa_id_pessoa )
WHERE  dt_demissao IS NULL
ORDER  BY dt_admissao 

-- Telefones e nomes dos instrutores
SELECT P.nome,
       P.sobrenome,
       I.titulacao,
       T.ddd,
       T.numero
FROM   pessoa P
       INNER JOIN instrutor I
               ON P.id_pessoa = I.fk_pessoa_id_pessoa
       INNER JOIN telefone T
               ON I.num_inscricao = T.fk_instrutor_num_inscricao 

--INSTRUTORES E SUAS RESPECTIVAS TURMAS
SELECT I.num_inscricao,
       I.titulacao,
       I.dt_demissao,
       T.horario,
       T.duracao,
       T.data_inicial
FROM   instrutor I
       LEFT JOIN turma T
              ON I.num_inscricao = T.fk_instrutor_num_inscricao 

-- Nome da turma, horário, duração, data inicial e data final
SELECT A.nome,
       T.horario,
       T.duracao,
       T.data_inicial,
       T.data_final
FROM   atividade A
       INNER JOIN turma T
               ON A.id_atividade = T.fk_atividade_id_atividade 

-- TURMAS QUE INICIAM EM 2022
SELECT A.NOME, 
	   T.HORARIO, 
	   T.DURACAO, 
	   T.DATA_INICIAL, 
	   T.DATA_FINAL, 
	   T.ID_TURMA 
FROM ATIVIDADE A
	   INNER JOIN TURMA T
			ON A.ID_ATIVIDADE = T.FK_ATIVIDADE_ID_ATIVIDADE
WHERE YEAR(DATA_INICIAL) = '2022' 


