<%-- 
    Document   : listar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%-- Configurações e Importações --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.DentistaDAO" %> <%-- Ferramenta para buscar no banco --%>
<%@ page import="model.Dentista" %>        <%-- Modelo de dados do Dentista --%>
<%@ page import="java.util.List" %>        <%-- Para manipular a lista de resultados --%>

<%-- 2. Estrutura Visual (Cabeçalho e Menu) --%>
<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11"> <%-- Largura da coluna (quase a tela toda) --%>
        
        <%-- Título e Botão de Adicionar --%>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-person-badge-fill me-2"></i> Dentistas
            </h2>
            <a href="cadastrar.jsp" class="btn btn-primary shadow-sm">
                <i class="bi bi-plus-lg"></i> Novo Dentista
            </a>
        </div>

        <%-- Alertas de Erro/Sucesso --%>
        <% 
            String erro = request.getParameter("erro");
            if ("fk_constraint".equals(erro)) {
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Erro!</strong> Não é possível excluir dentista com consultas agendadas.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <%-- Card Principal da Tabela --%>
        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-primary"><i class="bi bi-list-ul"></i> Equipe Médica</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        
                        <%-- Cabeçalho das Colunas --%>
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Nome</th>
                                <th>CRO</th>
                                <th>Especialidade</th>
                                <th>Telefone</th> 
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                            <%
                                // 1. Instancia o DAO
                                DentistaDAO dao = new DentistaDAO();
                                // 2. Busca todos os dentistas do banco
                                List<Dentista> lista = dao.listar();
                                
                                // 3. Verifica se a lista está vazia
                                if (lista.isEmpty()) {
                            %>
                                <%-- Se não tiver ninguém, mostra mensagem amigável --%>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="bi bi-emoji-frown display-4 d-block mb-3"></i>
                                        Nenhum dentista encontrado.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    // 4. Loop para mostrar cada dentista
                                    for (Dentista d : lista) {
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= d.getId() %></td>
                                
                                <td>
                                    <span class="fw-bold text-dark"><%= d.getNome() %></span>
                                </td>
                                
                                <td>
                                    <%-- Badge Azul para destacar o CRO --%>
                                    <span class="badge bg-primary bg-opacity-75"><%= d.getCro() %></span>
                                </td>
                                
                                <td><%= d.getEspecialidade() %></td>
                                
                                <%-- Verifica se tem telefone, senão mostra "---" --%>
                                <td><%= (d.getTelefone() != null) ? d.getTelefone() : "---" %></td>
                                
                                <td class="text-center">
                                    <div class="btn-group">
                                        <%-- Botão Editar --%>
                                        <a href="editar.jsp?id=<%= d.getId() %>" class="btn btn-sm btn-outline-primary" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        
                                        <%-- Botão Excluir com confirmação --%>
                                        <a href="excluir.jsp?id=<%= d.getId() %>" onclick="return confirm('Tem certeza que deseja excluir o dentista <%= d.getNome() %>?');" class="btn btn-sm btn-outline-danger" title="Excluir">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    } // Fim do for
                                } // Fim do else
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </div>
</div>

<%-- Rodapé --%>
<jsp:include page="/jsp/includes/footer.jsp" />