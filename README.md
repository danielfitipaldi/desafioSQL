# Desafio SQL
Desafio de Modelagem SQL 

## 1.	OBJETIVO

Este documento tem como finalidade descrever processo de criação de um sistema de banco de dados Microsoft SQL desenvolvido para uma academia.

## 2.	MODELO DE NEGÓCIO

Uma academia de ginástica deseja manter um controle do seu funcionamento. Os alunos são organizados em turmas associadas a um tipo específico de atividade. As informações sobre uma turma são número de alunos, horário da aula, duração da aula, data inicial, data final e tipo de atividade.
Cada turma é orientada por um único instrutor para o qual são cadastrados RG, nome, data de nascimento, titulação e todos os telefones possíveis para sua localização. Um instrutor pode orientar várias turmas que podem ser de diferentes atividades. Para cada turma existe um aluno monitor que auxilia o instrutor da turma, sendo que um aluno pode ser monitor no máximo em uma turma.
Os dados cadastrados dos alunos são: código de matrícula, data de matrícula, nome, endereço, telefone, data de nascimento, altura e peso. Um aluno pode estar matriculado em várias turmas se deseja realizar atividades diferentes e para cada matrícula é mantido um registro das ausências do aluno.

## 3.	FERRAMENTAS UTILIZADAS

Para o desenvolvimento deste projeto foram utilizadas as ferramentas: BrModelo e Microsoft SQL Server Management Studio 18

## 4. MODELO CONCEITUAL

![Modelo Conceitual](https://user-images.githubusercontent.com/56164041/191392701-1cdce9f5-6e98-4ced-b218-3d9bb9021fc2.png)

## 5. MODELO LÓGICO

![Modelo Lógico](https://user-images.githubusercontent.com/56164041/191392746-b8a45d69-c5fa-4ee4-9938-db279a776822.png)
