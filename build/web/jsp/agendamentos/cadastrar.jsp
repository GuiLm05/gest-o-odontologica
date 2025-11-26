<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.ConsultaDAO" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.DAO.ProcedimentoDAO" %>
<%@ page import="model.Consulta" %>
<%@ page import="model.Paciente" %>
<%@ page import="model.Dentista" %>
<%@ page import="model.Procedimento" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6"> <div class="card shadow-lg border-0 rounded-3">
                
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold"><i class="bi bi-calendar-plus me-2"></i> Agendar Consulta</h4>
                </div>

                <div class="card-body p-4">
                    
                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            try {
                                int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                                int idDentista = Integer.parseInt(request.getParameter("idDentista"));
                                int idProcedimento = Integer.parseInt(request.getParameter("idProcedimento"));
                                String dataStr = request.getParameter("data");
                                String observacoes = request.getParameter("observacoes");

                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                                Date dataConsulta = sdf.parse(dataStr);

                                Consulta c = new Consulta();
                                c.setIdPaciente(idPaciente);
                                c.setIdDentista(idDentista);
                                c.setDataConsulta(dataConsulta);
                                c.setObservacoes(observacoes);

                                ConsultaDAO dao = new ConsultaDAO();
                                
                                if (dao.inserir(c, idProcedimento)) {
                                    response.sendRedirect("listar.jsp");
                                } else {
                    %>
                                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                        <div>Erro ao salvar no banco de dados!</div>
                                    </div>
                    <%
                                }
                            } catch (Exception e) {
                    %>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>Erro: <%= e.getMessage() %></div>
                                </div>
                    <%
                                e.printStackTrace();
                            }
                        }
                    %>

                    <form method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">
                                <i class="bi bi-person-fill"></i> Paciente
                            </label>
                            <select name="idPaciente" class="form-select form-select-lg" required>
                                <option value="" selected disabled>Selecione o paciente...</option>
                                <%
                                    PacienteDAO pDao = new PacienteDAO();
                                    for (Paciente p : pDao.listar()) {
                                %>
                                    <option value="<%= p.getId() %>"><%= p.getNome() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">
                                <i class="bi bi-person-badge-fill"></i> Dentista
                            </label>
                            <select name="idDentista" class="form-select form-select-lg" required>
                                <option value="" selected disabled>Selecione o dentista...</option>
                                <%
                                    DentistaDAO dDao = new DentistaDAO();
                                    for (Dentista d : dDao.listar()) {
                                %>
                                    <option value="<%= d.getId() %>"><%= d.getNome() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">
                                <i class="bi bi-tools"></i> Procedimento (Serviço)
                            </label>
                            <div class="input-group">
                                <select name="idProcedimento" class="form-select form-select-lg" required>
                                    <option value="" selected disabled>Selecione o serviço...</option>
                                    <%
                                        ProcedimentoDAO procDao = new ProcedimentoDAO();
                                        for (Procedimento proc : procDao.listar()) {
                                    %>
                                        <option value="<%= proc.getId() %>">
                                            <%= proc.getNome() %> (R$ <%= proc.getValor() %>)
                                        </option>
                                    <% } %>
                                </select>
                                <span class="input-group-text bg-light"><i class="bi bi-cash-coin"></i></span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">
                                <i class="bi bi-clock-fill"></i> Data e Hora
                            </label>
                            <input type="datetime-local" name="data" class="form-control form-control-lg" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-secondary">
                                <i class="bi bi-card-text"></i> Observações
                            </label>
                            <textarea name="observacoes" class="form-control" rows="3" placeholder="Alguma observação especial?"></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg shadow-sm">
                                <i class="bi bi-check-lg"></i> Confirmar Agendamento
                            </button>
                            <a href="listar.jsp" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Voltar
                            </a>
                        </div>

                    </form>
                </div>
            </div>
            </div>
    </div>
</div>

<br><br>
<jsp:include page="/jsp/includes/footer.jsp" />