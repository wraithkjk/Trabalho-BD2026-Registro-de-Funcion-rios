// Função para buscar os dados do Back-end
async function carregarTabela() {
    try {
        const resposta = await fetch('http://localhost:3000/funcionarios');
        const funcionarios = await resposta.json();

        const corpoTabela = document.querySelector('tbody');
        corpoTabela.innerHTML = ''; // Limpa a tabela antes de preencher

        funcionarios.forEach(func => {
            corpoTabela.innerHTML += `
                <tr>
                    <td>${func.id_funcionario}</td>
                    <td>${func.nome}</td>
                    <td>${func.cargo}</td>
                    <td>${func.nome_depto || 'Sem Depto'}</td>
                    <td>R$ ${func.salario}</td>
                    <td>${func.telefone}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                        <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                    </td>
                </tr>
            `;
        });
    } catch (erro) {
        console.error("Erro ao conectar com o servidor Node:", erro);
    }
}

// Executa a função assim que a página carrega
document.addEventListener('DOMContentLoaded', carregarTabela);