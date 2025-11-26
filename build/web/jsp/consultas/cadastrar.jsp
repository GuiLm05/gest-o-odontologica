<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.ConsultaDAO" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.DAO.ProcedimentoDAO" %> <%@ page import="model.Consulta" %>
<%@ page import="model.Paciente" %>
<%@ page import="model.Dentista" %>
<%@ page import="model.Procedimento" %> <%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<h2>Agendar Nova Consulta</h2>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // 1. Pegar dados do formulário
            int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
            int idDentista = Integer.parseInt(request.getParameter("idDentista"));
            
            // NOVO: Pegar o procedimento escolhido
            int idProcedimento = Integer.parseInt(request.getParameter("idProcedimento"));
            
            String dataStr = request.getParameter("data");
            
            // CORREÇÃO: Pegar 'observacoes' em vez de 'descricao'
            String observacoes = request.getParameter("observacoes");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dataConsulta = sdf.parse(dataStr);

            Consulta c = new Consulta();
            c.setIdPaciente(idPaciente);
            c.setIdDentista(idDentista);
            c.setDataConsulta(dataConsulta);
            
            // CORREÇÃO: Usar o método certo
            c.setObservacoes(observacoes);

            ConsultaDAO dao = new ConsultaDAO();
            
            // CORREÇÃO: Passar o procedimento para o DAO
            if (dao.inserir(c, idProcedimento)) {
                response.sendRedirect("listar.jsp");
            } else {
                out.println("<p style='color:red'>Erro ao gravar no banco!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red'>Erro: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<form method="post">
    <label>Paciente:</label><br>
    <select name="idPaciente" required style="width: 300px;">
        <option value="">Selecione...</option>
        <%
            PacienteDAO pDao = new PacienteDAO();
            for (Paciente p : pDao.listar()) {
        %>
            <option value="<%= p.getId() %>"><%= p.getNome() %></option>
        <% } %>
    </select>
    <br><br>

    <label>Dentista:</label><br>
    <select name="idDentista" required style="width: 300px;">
        <option value="">Selecione...</option>
        <%
            DentistaDAO dDao = new DentistaDAO();
            for (Dentista d : dDao.listar()) {
        %>
            <option value="<%= d.getId() %>"><%= d.getNome() %></option>
        <% } %>
    </select>
    <br><br>

    <label>Procedimento:</label><br>
    <select name="idProcedimento" required style="width: 300px;">
        <option value="">Selecione...</option>
        <%
            ProcedimentoDAO procDao = new ProcedimentoDAO();
            for (Procedimento proc : procDao.listar()) {
        %>
            <option value="<%= proc.getId() %>">
                <%= proc.getNome() %> (R$ <%= proc.getValor() %>)
            </option>
        <% } %>
    </select>
    <br><br>

    <label>Data e Hora:</label><br>
    <input type="datetime-local" name="data" required>
    <br><br>

    <label>Observações:</label><br>
    <textarea name="observacoes" rows="3" cols="30"></textarea>
    <br><br>

    <button type="submit">Agendar</button>
</form>

<br>
<a href="listar.jsp">Voltar</a>

<jsp:include page="/jsp/includes/footer.jsp" />