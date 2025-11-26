<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.ConsultaDAO" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.DAO.ProcedimentoDAO" %> <%@ page import="model.Consulta" %>
<%@ page import="model.Paciente" %>
<%@ page import="model.Dentista" %>
<%@ page import="model.Procedimento" %> <%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<h2>Agendamentos</h2>

<a href="cadastrar.jsp">+ Nova Consulta</a>
<br><br>

<table border="1" cellpadding="8">
    <thead>
        <tr>
            <th>ID</th>
            <th>Paciente</th>
            <th>Dentista</th>
            <th>Procedimento</th> <th>Data e Hora</th>
            <th>Observações</th>
            <th>Ações</th>
        </tr>
    </thead>
    <tbody>
        <%
            ConsultaDAO dao = new ConsultaDAO();
            PacienteDAO pDao = new PacienteDAO();
            DentistaDAO dDao = new DentistaDAO();
            ProcedimentoDAO procDao = new ProcedimentoDAO(); // DAO NOVO
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

            for (Consulta c : dao.listar()) {
                Paciente p = pDao.buscarPorId(c.getIdPaciente());
                Dentista d = dDao.buscarPorId(c.getIdDentista());
                
                // BUSCA O PROCEDIMENTO DESTA CONSULTA
                Procedimento proc = procDao.buscarPorIdConsulta(c.getId());
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= (p != null) ? p.getNome() : "Desconhecido" %></td>
            <td><%= (d != null) ? d.getNome() : "Desconhecido" %></td>
            
            <td>
                <% if (proc != null) { %>
                    <%= proc.getNome() %> <br>
                    <small style="color: green;">(R$ <%= proc.getValor() %>)</small>
                <% } else { %>
                    ---
                <% } %>
            </td>
            
            <td><%= (c.getDataConsulta() != null) ? sdf.format(c.getDataConsulta()) : "--" %></td>
            <td><%= c.getObservacoes() %></td>
            
            <td>
                <a href="excluir.jsp?id=<%= c.getId() %>" onclick="return confirm('Cancelar agendamento?');" style="color:red;">Excluir</a>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<jsp:include page="/jsp/includes/footer.jsp" />