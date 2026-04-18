const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// 1. Configuração da conexão com o Banco de Dados
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', // seu usuário do MySQL
    password: 'myroot123', // sua senha do MySQL
    database: 'funcionarios_ifrn'
});

db.connect(err => {
    if (err) {
        console.error('Erro ao conectar ao MySQL:', err);
        return;
    }
    console.log('Conectado ao banco de dados funcionarios_ifrn!');
});

// 2. Rota para Listar Funcionários (GET)
// Essa rota vai buscar os dados para preencher sua tabela
app.get('/funcionarios', (req, res) => {
    const sql = `
        SELECT f.*, d.nome AS nome_depto 
        FROM funcionarios f 
        LEFT JOIN departamentos d ON f.id_depto = d.id_depto
    `;
    db.query(sql, (err, result) => {
        if (err) return res.status(500).json(err);
        return res.json(result);
    });
});

// 3. Rota para Cadastrar Funcionário (POST)
app.post('/funcionarios', (req, res) => {
    const { nome, cargo, salario, endereco, telefone, id_depto } = req.body;
    const sql = "INSERT INTO funcionarios (nome, cargo, salario, endereco, telefone, id_depto) VALUES (?, ?, ?, ?, ?, ?)";
    
    db.query(sql, [nome, cargo, salario, endereco, telefone, id_depto], (err, result) => {
        if (err) return res.status(500).json(err);
        return res.json({ message: "Funcionário cadastrado com sucesso!", id: result.insertId });
    });
});

// Iniciar o servidor na porta 3000
app.listen(3000, () => {
    console.log("Servidor rodando em http://localhost:3000");
});