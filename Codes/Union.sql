-- Nome, sobrenome e telefones de alunos e instrutores

SELECT P.nome,
       P.sobrenome,
       Concat(T.ddd, T.numero) AS TELEFONE
FROM   instrutor I
       INNER JOIN telefone T
               ON T.fk_instrutor_num_inscricao = I.num_inscricao
       INNER JOIN pessoa P
               ON P.id_pessoa = I.fk_pessoa_id_pessoa
UNION
SELECT P.nome,
       P.sobrenome,
       A.telefone
FROM   aluno A
       INNER JOIN pessoa P
               ON P.id_pessoa = A.fk_pessoa_id_pessoa
ORDER  BY P.nome 