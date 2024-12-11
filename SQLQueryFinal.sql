CREATE DATABASE Lanchonete_Restaurante;

CREATE TABLE LOJAS (
	loja_id CHAR(2) PRIMARY KEY NOT NULL,
	loja_cep VARCHAR(10) UNIQUE, 
	loja_endereco VARCHAR(255), 
	loja_uf CHAR(2)
);

CREATE TABLE FUNCIONARIOS (
	func_id CHAR(2) PRIMARY KEY NOT NULL,
	func_nome VARCHAR(255) NOT NULL, 
	func_cpf CHAR(11) UNIQUE, 
	func_especialidade VARCHAR(50), 
	loja_id CHAR(2),
	CONSTRAINT uni_lojafunc FOREIGN KEY (loja_id) REFERENCES LOJAS(loja_id)
);

CREATE TABLE FORNECEDORES (
	forneproduto_id INT PRIMARY KEY NOT NULL, 
	fornecedor_sif_gov CHAR(100) UNIQUE, 
	produto_lote VARCHAR(255) NOT NULL, 
	nome_fornecedor VARCHAR(255)
);

CREATE TABLE ESTOQUE (
	produto_id INT PRIMARY KEY NOT NULL, 
	produto_nome VARCHAR(255) NOT NULL, 
	produto_validade DATE NOT NULL, 
	produto_quantidade_kg CHAR(100) NOT NULL,
	CONSTRAINT uni_funcfornestoque FOREIGN KEY (produto_id) REFERENCES FORNECEDORES (forneproduto_id)
);

CREATE TABLE PEDIDOS (
	pedido_id CHAR(2) PRIMARY KEY NOT NULL, 
	produto_pedido VARCHAR(255), 
	pedido_hora TIME,
	pedido_preco DECIMAL(10,2)
);

CREATE TABLE CLIENTES (
	cliente_id CHAR(2) PRIMARY KEY NOT NULL, 
	cliente_cpf CHAR(11) UNIQUE, 
	cliente_nome VARCHAR(255), 
	cliente_loja_id CHAR(2),
	CONSTRAINT uni_pediclientes FOREIGN KEY (cliente_loja_id) REFERENCES LOJAS(loja_id)
);

/* INSERÇÕES */

INSERT INTO LOJAS VALUES ('01', '0000000', 'Rua Me da 10 Professor - São Paulo', 'SP');

INSERT INTO FUNCIONARIOS VALUES ('1', 'Maria Ganha Dez', '10000000000', 'Churrasco', '01'); 
INSERT INTO FUNCIONARIOS VALUES ('2', 'Guina', '20000000000', 'Francesa', '01');
INSERT INTO FUNCIONARIOS VALUES ('3', 'Cleiton Rasta', '30000000000', 'Ervas Medicinais', '01'); 
INSERT INTO FUNCIONARIOS VALUES ('4', 'Rodrigo Goes', '40000000000', 'Sucos', '01');
INSERT INTO FUNCIONARIOS VALUES ('5', 'Bluyi LePen', '50000000000', 'Assinatura Temperada', '01');

INSERT INTO CLIENTES VALUES ('01', '11122233344', 'Marco', '01');
INSERT INTO CLIENTES VALUES ('02', '22233344455', 'Livia', '01');
INSERT INTO CLIENTES VALUES ('03', '33344455566', 'Rodrigo', '01');
INSERT INTO CLIENTES VALUES ('04', '44455566677', 'Armando', '01');
INSERT INTO CLIENTES VALUES ('05', '55566677788', 'Isabela', '01');

INSERT INTO FORNECEDORES VALUES (101, '150', 'LOTE24/24', 'LaticiniosdaFazenda'); 
INSERT INTO FORNECEDORES VALUES (102, '336', 'LOT3carne22', 'FriGado');
INSERT INTO FORNECEDORES VALUES (103, '321', 'LOTE09/2024', 'FrutariaHortiFrutiGraos'); 
INSERT INTO FORNECEDORES VALUES (104, '654', 'LOT3/2024', 'GranjaOvoGrosso');

INSERT INTO ESTOQUE VALUES (101,'CorteBananinhaBoi','2001-01-25',50); 
INSERT INTO ESTOQUE VALUES (102,'Bebidas','2001-01-25',50);
INSERT INTO ESTOQUE VALUES (103,'Fruta e Legumes','2001-01-25',50); 
INSERT INTO ESTOQUE VALUES (104,'Doces e Salgados','2001-01-25',50);

INSERT INTO PEDIDOS VALUES ('01','6 espetos a moda','12:30',29.99);
INSERT INTO PEDIDOS VALUES ('02','Feijoada Branca sem Linguiça','09:10',39.99); 
INSERT INTO PEDIDOS VALUES ('03','2 espetos a moda com pinga','07:30',9.99);
INSERT INTO PEDIDOS VALUES ('04','Mix Salada Diet','18:30',9.99);

SELECT CLIENTES.cliente_id, PEDIDOS.pedido_id
FROM CLIENTES
INNER JOIN PEDIDOS ON CLIENTES.cliente_id = PEDIDOS.pedido_id;

SELECT FUNCIONARIOS.func_id, LOJAS.loja_id
FROM FUNCIONARIOS
INNER JOIN LOJAS ON FUNCIONARIOS.loja_id = LOJAS.loja_id;

CREATE VIEW lojas_funcionarios_vw AS
SELECT FUNCIONARIOS.func_id, FUNCIONARIOS.func_nome, FUNCIONARIOS.func_cpf, LOJAS.loja_id, LOJAS.loja_cep, LOJAS.loja_endereco, LOJAS.loja_uf
FROM FUNCIONARIOS
JOIN LOJAS ON FUNCIONARIOS.loja_id = LOJAS.loja_id
WHERE FUNCIONARIOS.func_id > '1';

SELECT * FROM lojas_funcionarios_vw;

CREATE VIEW pedidos_clientes_vw AS
SELECT PEDIDOS.pedido_id, PEDIDOS.pedido_preco, PEDIDOS.produto_pedido, CLIENTES.cliente_nome, CLIENTES.cliente_cpf, CLIENTES.cliente_id
FROM PEDIDOS
JOIN CLIENTES ON PEDIDOS.pedido_id = CLIENTES.cliente_id
WHERE PEDIDOS.pedido_id <> 0;

SELECT * FROM pedidos_clientes_vw;