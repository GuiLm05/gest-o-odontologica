<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.Paciente" %>
<%@ page import="java.util.List" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-people-fill me-2"></i> Pacientes
            </h2>
            <a href="cadastrar.jsp" class="btn btn-success shadow-sm">
                <i class="bi bi-person-plus-fill"></i> Novo Paciente
            </a>
        </div>

        <% 
            String erro = request.getParameter("erro");
            String msg = request.getParameter("msg");

            if ("fk_constraint".equals(erro)) {
        %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-octagon-fill me-2"></i>
                <strong>Não foi possível excluir!</strong> Este paciente possui histórico de consultas.
                <br><small>Remova os agendamentos dele antes de tentar excluir.</small>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
            } else if ("sucesso".equals(msg)) {
        %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Paciente removido com sucesso!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-success"><i class="bi bi-journal-medical"></i> Lista de Registros</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
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
                                List<Paciente> lista = dao.listar();
                                
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
                                    for (Paciente p : lista) {
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= p.getId() %></td>
                                <td>
                                    <span class="fw-bold text-dark"><%= p.getNome() %></span>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border">
                                        <%= (p.getCpf() != null) ? p.getCpf() : "---" %>
                                    </span>
                                </td>
                                <td><%= (p.getTelefone() != null) ? p.getTelefone() : "" %></td>
                                <td><%= (p.getEmail() != null) ? p.getEmail() : "" %></td>
                                
                                <td class="text-center">
                                    <div class="btn-group">
                                        <a href="editar.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-outline-primary" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        
                                        <a href="excluir.jsp?id=<%= p.getId() %>" onclick="return confirm('Tem certeza que deseja remover o paciente <%= p.getNome() %>?');" class="btn btn-sm btn-outline-danger" title="Excluir">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/jsp/includes/footer.jsp" />