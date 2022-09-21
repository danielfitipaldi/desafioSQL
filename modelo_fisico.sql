CREATE DATABASE DATAMONSTERS

USE DATAMONSTERS

/* CRIANDO TABELAS SEM FK */
CREATE TABLE PESSOA (
    ID_PESSOA INT PRIMARY KEY IDENTITY(1,1),
    RG CHAR(9) NOT NULL,
    NOME VARCHAR(30) NOT NULL,
    SOBRENOME VARCHAR(30) NOT NULL,
    DTNASC DATE NOT NULL,
    SEXO CHAR(2) NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE ATIVIDADE (
    ID_ATIVIDADE INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(50) NOT NULL
);

/* DEMAIS TABELAS */

CREATE TABLE ENDERECO (
    ID INT PRIMARY KEY IDENTITY(1,1),
    RUA VARCHAR(40) NOT NULL,
    BAIRRO VARCHAR(30) NOT NULL,
    CIDADE VARCHAR(30) NOT NULL,
    ESTADO CHAR(2) NOT NULL,
    FK_PESSOA_ID_PESSOA INT 
);

CREATE TABLE INSTRUTOR (
    NUM_INSCRICAO INT PRIMARY KEY IDENTITY(1,1),
    TITULACAO VARCHAR(30) NOT NULL,
    DT_ADMISSAO DATE NOT NULL,
    DT_DEMISSAO DATE NULL,
    FK_PESSOA_ID_PESSOA INT
);
 
CREATE TABLE TELEFONE (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DDD CHAR(2) NOT NULL,
    NUMERO CHAR(9) NOT NULL,
    FK_INSTRUTOR_NUM_INSCRICAO INT FOREIGN KEY REFERENCES INSTRUTOR(NUM_INSCRICAO)
);


CREATE TABLE TURMA (
    ID_TURMA INT PRIMARY KEY IDENTITY(1,1),
    HORARIO TIME NOT NULL,
    DURACAO VARCHAR(6) NOT NULL,
    DATA_INICIAL DATE NOT NULL,
    DATA_FINAL DATE NOT NULL,
    FK_ATIVIDADE_ID_ATIVIDADE INT,
    FK_INSTRUTOR_NUM_INSCRICAO INT
);

CREATE TABLE ALUNO (
    ID_ALUNO INT PRIMARY KEY IDENTITY(1,1),
    DT_MATRICULA DATE NOT NULL,
    DT_TRANCAMENTO DATE NULL,
    PESO DECIMAL(5,2) NOT NULL,
    ALTURA DECIMAL(5,2) NOT NULL,
    TELEFONE CHAR(11) NOT NULL,
    FK_PESSOA_ID_PESSOA INT,
    FK_TURMA_ID_TURMA INT
);



CREATE TABLE MATRICULA (
    ID_MATRICULA INT PRIMARY KEY IDENTITY(1,1),
    FK_ALUNO_ID_ALUNO INT,
    FK_TURMA_ID_TURMA INT 
);

CREATE TABLE PRESENCA (
    ID_PRESENCA INT PRIMARY KEY IDENTITY(1,1),
    DATA_AULA DATE NOT NULL,
    PRESENTE BIT NOT NULL,
    FK_MATRICULA_ID_MATRICULA INT
);


ALTER TABLE ALUNO ADD CONSTRAINT FK_ALUNO_2
    FOREIGN KEY (FK_PESSOA_ID_PESSOA)
    REFERENCES PESSOA (ID_PESSOA)
    ON DELETE CASCADE;
 
ALTER TABLE ALUNO ADD CONSTRAINT FK_ALUNO_3
    FOREIGN KEY (FK_TURMA_ID_TURMA)
    REFERENCES TURMA (ID_TURMA)
    ON DELETE CASCADE;
 
ALTER TABLE TURMA ADD CONSTRAINT FK_TURMA_2
    FOREIGN KEY (FK_ATIVIDADE_ID_ATIVIDADE)
    REFERENCES ATIVIDADE (ID_ATIVIDADE)
    ON DELETE NO ACTION;
 
ALTER TABLE TURMA ADD CONSTRAINT FK_TURMA_3
    FOREIGN KEY (FK_INSTRUTOR_NUM_INSCRICAO)
    REFERENCES INSTRUTOR (NUM_INSCRICAO)
    ON DELETE NO ACTION;
 
ALTER TABLE INSTRUTOR ADD CONSTRAINT FK_INSTRUTOR_2
    FOREIGN KEY (FK_PESSOA_ID_PESSOA)
    REFERENCES PESSOA (ID_PESSOA)
    ON DELETE CASCADE;
 
 
ALTER TABLE MATRICULA ADD CONSTRAINT FK_MATRICULA_2
    FOREIGN KEY (FK_ALUNO_ID_ALUNO)
    REFERENCES ALUNO (ID_ALUNO)
    ON DELETE CASCADE;
 
ALTER TABLE MATRICULA ADD CONSTRAINT FK_MATRICULA_3
    FOREIGN KEY (FK_TURMA_ID_TURMA)
    REFERENCES TURMA (ID_TURMA)
    ON DELETE no action;
 
ALTER TABLE PRESENCA ADD CONSTRAINT FK_PRESENCA_2
    FOREIGN KEY (FK_MATRICULA_ID_MATRICULA)
    REFERENCES MATRICULA (ID_MATRICULA)
    ON DELETE CASCADE;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_2
    FOREIGN KEY (FK_PESSOA_ID_PESSOA)
    REFERENCES PESSOA (ID_PESSOA)
    ON DELETE CASCADE;