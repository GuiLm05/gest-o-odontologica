<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.Dentista" %>
<%@ page import="java.util.List" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11"> <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-person-badge-fill me-2"></i> Dentistas
            </h2>
            <a href="cadastrar.jsp" class="btn btn-primary shadow-sm">
                <i class="bi bi-plus-lg"></i> Novo Dentista
            </a>
        </div>

        <% 
            String erro = request.getParameter("erro");
            String msg = request.getParameter("msg");

            if ("fk_constraint".equals(erro)) {
        %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-octagon-fill me-2"></i>
                <strong>Não foi possível excluir!</strong> Este dentista possui consultas vinculadas.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
            } else if ("sucesso".equals(msg)) {
        %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Operação realizada com sucesso!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-primary"><i class="bi bi-list-ul"></i> Equipe Médica</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Nome</th>
                                <th>CRO</th>
                                <th>Especialidade</th>
                                <th>Telefone</th> <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                DentistaDAO dao = new DentistaDAO();
                                List<Dentista> lista = dao.listar();
                                
                                if (lista.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="bi bi-emoji-frown display-4 d-block mb-3"></i>
                                        Nenhum dentista encontrado.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    for (Dentista d : lista) {
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= d.getId() %></td>
                                <td>
                                    <span class="fw-bold text-dark"><%= d.getNome() %></span>
                                </td>
                                <td>
                                    <span class="badge bg-primary bg-opacity-75"><%= d.getCro() %></span>
                                </td>
                                <td><%= d.getEspecialidade() %></td>
                                
                                <td><%= (d.getTelefone() != null) ? d.getTelefone() : "---" %></td>
                                
                                <td class="text-center">
                                    <div class="btn-group">
                                        <a href="editar.jsp?id=<%= d.getId() %>" class="btn btn-sm btn-outline-primary" title="Editar">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        
                                        <a href="excluir.jsp?id=<%= d.getId() %>" onclick="return confirm('Tem certeza que deseja excluir o dentista <%= d.getNome() %>?');" class="btn btn-sm btn-outline-danger" title="Excluir">
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