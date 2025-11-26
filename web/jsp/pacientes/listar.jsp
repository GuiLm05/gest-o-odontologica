<%-- 
    Document   : listar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%-- Configurações e Importações --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.PacienteDAO" %> <%-- Ferramenta para buscar no banco --%>
<%@ page import="model.Paciente" %>        <%-- Modelo de dados do Paciente --%>
<%@ page import="java.util.List" %>        <%-- Para manipular a lista --%>

<%-- 2. Estrutura Visual (Cabeçalho e Menu) --%>
<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11"> <%-- Largura da tabela --%>

        <%-- Título e Botão de Adicionar --%>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-people-fill me-2"></i> Pacientes
            </h2>
            <%-- Botão Verde para combinar com a área de Pacientes --%>
            <a href="cadastrar.jsp" class="btn btn-success shadow-sm">
                <i class="bi bi-person-plus-fill"></i> Novo Paciente
            </a>
        </div>

        <%-- 3. SISTEMA DE ALERTAS (Feedback visual) --%>
        <% 
            // Verifica se a URL tem parâmetros de erro ou sucesso (vindos do excluir.jsp)
            String erro = request.getParameter("erro");
            String msg = request.getParameter("msg");

            // Se tiver erro de chave estrangeira (tem consultas agendadas)
            if ("fk_constraint".equals(erro)) {
        %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-octagon-fill me-2"></i>
                <strong>Não foi possível excluir!</strong> Este paciente possui histórico de consultas.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
            // Se a exclusão funcionou
            } else if ("sucesso".equals(msg)) {
        %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Paciente removido com sucesso!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <%-- Card da Tabela --%>
        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-success"><i class="bi bi-journal-medical"></i> Lista de Registros</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        
                        <%-- Cabeçalho da Tabela --%>
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Nome</th>
                                <th>CPF</th>
                                <th>Telefone</th>
                                <th>Email</th>
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                            <%
                                PacienteDAO dao = new PacienteDAO();
                                // Busca todos os pacientes
                                List<Paciente> lista = dao.listar();
                                
                                // Se a lista estiver vazia, mostra mensagem
                                if (lista.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="bi bi-person-x display-4 d-block mb-3"></i>
                                        Nenhum paciente encontrado.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    // Loop para mostrar cada paciente
                                    for (Paciente p : lista) {
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= p.getId() %></td>
                                
                                <td>
                                    <span class="fw-bold text-dark"><%= p.getNome() %></span>
                                </td>
                                
                                <td>
                                    <%-- Badge Cinza Claro para o CPF --%>
                                    <span class="badge bg-light text-dark border">
                                        <%-- Verifica se tem CPF, senão mostra "---" --%>
                                        <%= (p.getCpf() != null) ? p.getCpf() : "---" %>
                                    </span>
                                </td>
                                
                                <td><%= (p.getTelefone() != null) ? p.getTelefone() : "" %></td>
                                <td><%= (p.getEmail() != null) ? p.getEmail() : "" %></td>
                                
                                <td class="text-center">
                                    <div class="btn-group">
                                        <%-- Botão Editar --%>
                                        <a href="editar.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-outline-primary" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        
                                        <%-- Botão Excluir com Confirmação --%>
                                        <a href="excluir.jsp?id=<%= p.getId() %>" onclick="return confirm('Tem certeza que deseja remover o paciente <%= p.getNome() %>?');" class="btn btn-sm btn-outline-danger" title="Excluir">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    } // Fim do loop
                                } // Fim do else
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/jsp/includes/footer.jsp" />