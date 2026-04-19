DROP DATABASE IF EXISTS funcionarios_ifrn;
CREATE DATABASE funcionarios_ifrn;
USE funcionarios_ifrn;

-- ========================
-- 1. TABELA USUARIOS (Topo da Hierarquia)
-- ========================
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('ADM', 'CHEFE', 'FUNC') DEFAULT 'FUNC'
);

-- ========================
-- 2. TABELA DEPARTAMENTOS
-- ========================
CREATE TABLE departamentos (
id_depto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
localizacao VARCHAR(100),
telefone VARCHAR(15)
);

-- ========================
-- 3. TABELA CHEFES
-- ========================
CREATE TABLE chefes (
id_chefe INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
id_depto INT,
id_usuario INT, -- Ligação com Usuario (U)
FOREIGN KEY (id_depto) REFERENCES departamentos(id_depto),
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ========================
-- 4. TABELA FUNCIONARIOS
-- ========================
CREATE TABLE funcionarios (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
endereco VARCHAR(150),
telefone VARCHAR(15),
id_depto INT,
id_chefe INT,
id_usuario INT, -- Ligação com Usuario (U)
FOREIGN KEY (id_depto) REFERENCES departamentos(id_depto),
FOREIGN KEY (id_chefe) REFERENCES chefes(id_chefe),
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ============================================================
-- INSERTS (MANTENDO TODOS OS SEUS DADOS ORIGINAIS)
-- ============================================================

-- Criando usuários base para os registros
INSERT INTO usuarios (login, senha, perfil) VALUES 
('admin', '123', 'ADM'), ('ana.chefe', '123', 'CHEFE'), ('carla.chefe', '123', 'CHEFE'),
('marcos.func', '123', 'FUNC'), ('carlos.func', '123', 'FUNC'), ('pedro.func', '123', 'FUNC');

-- SEUS 30 DEPARTAMENTOS ORIGINAIS
INSERT INTO departamentos (nome, localizacao, telefone) VALUES
('Informática','Bloco A','84990000001'),('Administração','Bloco B','84990000002'),
('Matemática','Bloco C','84990000003'),('Português','Bloco D','84990000004'),
('Biblioteca','Bloco E','84990000005'),('Coordenação','Bloco F','84990000006'),
('Laboratório','Bloco G','84990000007'),('Serviços Gerais','Bloco H','84990000008'),
('Segurança','Entrada','84990000009'),('Recepção','Entrada Principal','84990000010'),
('Diretoria','Bloco I','84990000011'),('Financeiro','Bloco J','84990000012'),
('Recursos Humanos','Bloco K','84990000013'),('Pedagógico','Bloco L','84990000014'),
('Química','Bloco M','84990000015'),('Física','Bloco N','84990000016'),
('Biologia','Bloco O','84990000017'),('História','Bloco P','84990000018'),
('Geografia','Bloco Q','84990000019'),('Inglês','Bloco R','84990000020'),
('TI Suporte','Bloco S','84990000021'),('TI Desenvolvimento','Bloco T','84990000022'),
('Almoxarifado','Bloco U','84990000023'),('Transporte','Garagem','84990000024'),
('Psicologia','Bloco V','84990000025'),('Assistência Social','Bloco W','84990000026'),
('Secretaria','Bloco X','84990000027'),('Eventos','Bloco Y','84990000028'),
('Comunicação','Bloco Z','84990000029'),('Planejamento','Bloco AA','84990000030');

-- INSERT CHEFES
INSERT INTO chefes (nome, id_depto, id_usuario) VALUES 
('Ana Pereira', 6, 2), ('Carla Vieira', 11, 3);

-- SEUS 30 FUNCIONÁRIOS ORIGINAIS (Agora com FK de Usuario e Chefe)
INSERT INTO funcionarios (nome, cargo, salario, endereco, telefone, id_depto, id_chefe, id_usuario) VALUES
('Marcos Oliveira','Professor Informática',5500.00,'Rua A, 123','84981111111',1, 1, 4),
('Ana Pereira','Coordenadora TI',7000.00,'Rua B, 45','84982222222',6, NULL, 2),
('Carlos Silva','Técnico TI',3200.00,'Rua C, 67','84983333333',21, 1, 5),
('Fernanda Souza','Secretária',2500.00,'Rua D, 89','84984444444',27, 2, NULL),
('João Santos','Professor Matemática',4800.00,'Rua E, 101','84985555555',3, NULL, NULL),
('Luciana Costa','Bibliotecária',3000.00,'Rua F, 202','84986666666',5, NULL, NULL),
('Pedro Alves','Auxiliar Administrativo',2000.00,'Rua G, 303','84987777777',2, 1, 6),
('Juliana Lima','Professora Português',4700.00,'Rua H, 404','84988888888',4, NULL, NULL),
('Rafael Gomes','Analista de Sistemas',6000.00,'Rua I, 505','84989999999',22, 1, NULL),
('Camila Rocha','Coordenadora Pedagógica',6500.00,'Rua J, 606','84981112222',14, 2, NULL),
('Bruno Martins','Técnico Laboratório',3100.00,'Rua K, 707','84981113333',7, NULL, NULL),
('Patrícia Freitas','Assistente Social',3500.00,'Rua L, 808','84981114444',26, NULL, NULL),
('Ricardo Barros','Professor Física',5000.00,'Rua M, 909','84981115555',16, NULL, NULL),
('Aline Mendes','Professora Química',4900.00,'Rua N, 111','84981116666',15, NULL, NULL),
('Diego Ribeiro','Segurança',1800.00,'Rua O, 222','84981117777',9, NULL, NULL),
('Vanessa Cardoso','Recepcionista',2100.00,'Rua P, 333','84981118888',10, NULL, NULL),
('Eduardo Nunes','Analista TI',5800.00,'Rua Q, 444','84981119999',21, 1, NULL),
('Tatiane Duarte','Professora História',4600.00,'Rua R, 555','84981220000',18, NULL, NULL),
('Fábio Carvalho','Motorista',2200.00,'Rua S, 666','84981221111',24, NULL, NULL),
('Simone Teixeira','Coordenadora Acadêmica',7200.00,'Rua T, 777','84981222222',6, 2, NULL),
('Lucas Fernandes','Estagiário TI',1200.00,'Rua U, 888','84981223333',21, 1, NULL),
('Daniela Batista','Auxiliar Biblioteca',1900.00,'Rua V, 999','84981224444',5, NULL, NULL),
('Gustavo Henrique','Professor Biologia',4800.00,'Rua W, 111','84981225555',17, NULL, NULL),
('Renata Lopes','Psicóloga',4000.00,'Rua X, 222','84981226666',25, NULL, NULL),
('Thiago Melo','Suporte Técnico',3300.00,'Rua Y, 333','84981227777',21, 1, NULL),
('Beatriz Ramos','Professora Inglês',4700.00,'Rua Z, 444','84981228888',20, NULL, NULL),
('André Costa','Administrador',5500.00,'Rua AA, 555','84981229999',2, NULL, NULL),
('Larissa Pinto','Assistente Administrativo',2300.00,'Rua AB, 666','84981330000',2, NULL, NULL),
('Marcelo Dias','Professor Geografia',4600.00,'Rua AC, 777','84981331111',19, NULL, NULL),
('Carla Vieira','Diretora',9000.00,'Rua AD, 888','84981332222',11, NULL, NULL);