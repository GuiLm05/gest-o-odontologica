<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.ConsultaDAO" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.DAO.ProcedimentoDAO" %>
<%@ page import="model.Consulta" %>
<%@ page import="model.Paciente" %>
<%@ page import="model.Dentista" %>
<%@ page import="model.Procedimento" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-calendar-check-fill me-2"></i> Agendamentos
            </h2>
            <a href="cadastrar.jsp" class="btn btn-success shadow-sm">
                <i class="bi bi-plus-lg"></i> Nova Consulta
            </a>
        </div>

        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-primary"><i class="bi bi-clock-history"></i> Consultas Marcadas</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Paciente</th>
                                <th>Dentista</th>
                                <th>Procedimento / Valor</th> <th>Data e Hora</th>
                                <th>Observações</th>
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ConsultaDAO dao = new ConsultaDAO();
                                PacienteDAO pDao = new PacienteDAO();
                                DentistaDAO dDao = new DentistaDAO();
                                ProcedimentoDAO procDao = new ProcedimentoDAO();
                                
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                List<Consulta> lista = dao.listar();

                                if (lista.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-calendar-x display-4 d-block mb-3"></i>
                                        Nenhuma consulta agendada.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    for (Consulta c : lista) {
                                        Paciente p = pDao.buscarPorId(c.getIdPaciente());
                                        Dentista d = dDao.buscarPorId(c.getIdDentista());
                                        
                                        // Busca o Procedimento para mostrar o Valor
                                        Procedimento proc = procDao.buscarPorIdConsulta(c.getId());
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= c.getId() %></td>
                                
                                <td>
                                    <i class="bi bi-person text-secondary"></i>
                                    <%= (p != null) ? p.getNome() : "<span class='text-danger'>Removido</span>" %>
                                </td>
                                
                                <td>
                                    <i class="bi bi-person-badge text-info"></i>
                                    <%= (d != null) ? d.getNome() : "---" %>
                                </td>
                                
                                <td>
                                    <% if (proc != null) { %>
                                        <span class="fw-bold text-dark"><%= proc.getNome() %></span><br>
                                        <span class="badge bg-success bg-opacity-75">
                                            R$ <%= String.format("%.2f", proc.getValor()) %>
                                        </span>
                                    <% } else { %>
                                        <span class="text-muted small">Não informado</span>
                                    <% } %>
                                </td>
                                
                                <td>
                                    <span class="text-primary fw-bold">
                                        <%= (c.getDataConsulta() != null) ? sdf.format(c.getDataConsulta()) : "--" %>
                                    </span>
                                </td>
                                
                                <td>
                                    <small class="text-muted"><%= (c.getObservacoes() != null) ? c.getObservacoes() : "" %></small>
                                </td>
                                
                                <td class="text-center">
                                    <a href="excluir.jsp?id=<%= c.getId() %>" onclick="return confirm('Deseja realmente cancelar este agendamento?');" class="btn btn-sm btn-outline-danger" title="Cancelar">
                                        <i class="bi bi-trash"></i> Cancelar
                                    </a>
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