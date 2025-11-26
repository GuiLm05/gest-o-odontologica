<%-- 
    Document   : listar.jsp
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Importando as classes de Modelo (Dados) --%>
<%@ page import="model.Consulta" %>
<%@ page import="model.Paciente" %>
<%@ page import="model.Dentista" %>
<%@ page import="model.Procedimento" %>

<%-- Importando os DAOs (Acesso ao Banco de Dados) --%>
<%@ page import="model.DAO.ConsultaDAO" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.DAO.ProcedimentoDAO" %>

<%-- Utilitários Java (Listas e Datas) --%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%-- INCLUINDO CABEÇALHO E MENU --%>
<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="row justify-content-center">
    <div class="col-md-11">

        <%-- CABEÇALHO DA PÁGINA --%>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-secondary fw-bold">
                <i class="bi bi-calendar-check-fill me-2"></i> Agendamentos
            </h2>
            <%-- Botão que leva para a tela de cadastro --%>
            <a href="cadastrar.jsp" class="btn btn-primary shadow-sm">
                <i class="bi bi-plus-lg"></i> Novo Agendamento
            </a>
        </div>

        <%-- 3. FEEDBACK VISUAL (Mensagens de Sucesso) --%>
        <% 
            // Verifica se a URL tem ?msg=sucesso (vindo do excluir.jsp)
            String msg = request.getParameter("msg");
            if ("sucesso".equals(msg)) {
        %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Agendamento cancelado/excluído com sucesso!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <%-- CARD DA TABELA (Design) --%>
        <div class="card shadow border-0">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="card-title mb-0 text-primary"><i class="bi bi-clock-history"></i> Consultas Marcadas</h5>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        
                        <%-- Cabeçalho da Tabela --%>
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Paciente</th>
                                <th>Dentista</th>
                                <th>Procedimento / Valor</th>
                                <th>Data e Hora</th>
                                <th>Observações</th>
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                            <%
                                // --- LÓGICA JAVA (BACKEND) ---
                                
                                // Instanciando os DAOs para buscar dados
                                ConsultaDAO dao = new ConsultaDAO();
                                PacienteDAO pDao = new PacienteDAO();
                                DentistaDAO dDao = new DentistaDAO();
                                ProcedimentoDAO procDao = new ProcedimentoDAO();
                                
                                // Formatador de Data (deixa a data bonita: 25/11/2025 14:00)
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                
                                // Busca a lista completa de consultas no banco
                                List<Consulta> lista = dao.listar();

                                // Verifica se a lista está vazia
                                if (lista.isEmpty()) {
                            %>
                                <%-- Se não tiver consultas, mostra aviso amigável --%>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-calendar-x display-4 d-block mb-3"></i>
                                        <br>Nenhuma consulta agendada.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    // --- LOOP DE DADOS ---
                                    // Para cada consulta encontrada, cria uma linha na tabela
                                    for (Consulta c : lista) {
                                        
                                        // Busca os NOMES baseados nos IDs salvos na consulta
                                        Paciente p = pDao.buscarPorId(c.getIdPaciente());
                                        Dentista d = dDao.buscarPorId(c.getIdDentista());
                                        Procedimento proc = procDao.buscarPorIdConsulta(c.getId());
                            %>
                            <tr>
                                <td class="ps-4 fw-bold">#<%= c.getId() %></td>
                                
                                <%-- Coluna Paciente --%>
                                <td>
                                    <i class="bi bi-person-fill text-secondary me-1"></i>
                                    <%-- Se p for nulo (paciente excluído), mostra "Removido" --%>
                                    <span class="fw-semibold text-dark"><%= (p != null) ? p.getNome() : "Removido" %></span>
                                </td>
                                
                                <%-- Coluna Dentista --%>
                                <td>
                                    <i class="bi bi-person-badge-fill text-info me-1"></i>
                                    <%= (d != null) ? d.getNome() : "---" %>
                                </td>
                                
                                <%-- Coluna Procedimento e Valor --%>
                                <td>
                                    <% if (proc != null) { %>
                                        <div><%= proc.getNome() %></div>
                                        <%-- Badge Verde para o Preço --%>
                                        <span class="badge bg-success bg-opacity-75 mt-1">
                                            R$ <%= String.format("%.2f", proc.getValor()) %>
                                        </span>
                                    <% } else { %>
                                        <span class="text-muted small">---</span>
                                    <% } %>
                                </td>
                                
                                <%-- Coluna Data --%>
                                <td>
                                    <div class="d-flex align-items-center text-primary fw-bold">
                                        <i class="bi bi-clock me-2"></i>
                                        <%= (c.getDataConsulta() != null) ? sdf.format(c.getDataConsulta()) : "--" %>
                                    </div>
                                </td>
                                
                                <%-- Coluna Observações --%>
                                <td class="text-muted small">
                                    <%= (c.getObservacoes() != null && !c.getObservacoes().isEmpty()) ? c.getObservacoes() : "---" %>
                                </td>
                                
                                <%-- Coluna Ações (Botão Cancelar) --%>
                                <td class="text-center">
                                    <a href="excluir.jsp?id=<%= c.getId() %>" onclick="return confirm('Deseja realmente cancelar o agendamento #<%= c.getId() %>?');" class="btn btn-sm btn-outline-danger shadow-sm" title="Cancelar Agendamento">
                                        <i class="bi bi-x-circle"></i> Cancelar
                                    </a>
                                </td>
                            </tr>
                            <%
                                    } // Fim do loop for
                                } // Fim do else
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<%-- Inclui o rodapé padrão --%>
<jsp:include page="/jsp/includes/footer.jsp" />