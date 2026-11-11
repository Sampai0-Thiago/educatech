CREATE DATABASE educatech;

USE educatech;

CREATE TABLE alunos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_nascimento DATE,
    telefone CHAR(11),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE alunos MODIFY COLUMN telefone INT(11);

CREATE TABLE IF NOT EXISTS professores(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(11),
    especialidade VARCHAR(100)
);

CREATE TABLE cursos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    carga_horaria INT NOT NULL CHECK(carga_horaria > 0),
    valor DECIMAL(10,2) NOT NULL CHECK(valor >= 0),
    professor_id INT NOT NULL REFERENCES professores(id) ,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE matricula(
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_matricula DATETIME DEFAULT CURRENT_TIMESTAMP,
    nota_final DECIMAL(4,2),
    situacao ENUM(
        'EM_ANDAMENTO',
        'CONCLUIDA',
        'CANCELADA'
    ) NOT NULL DEFAULT 'EM_ANDAMENTO',
    CONSTRAINT chk_nota_final 
        CHECK (nota_final BETWEEN 0 AND 10 OR nota_final IS NULL),

    CONSTRAINT uk_aluno_curso
        UNIQUE (aluno_id, curso_id),

    CONSTRAINT fk_matriculas_cursos
        FOREIGN KEY (curso_id)
        REFERENCES cursos(id)
);