<%-- 
    Document   : listar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%-- Configurações da página --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Importações: Trazendo as ferramentas (Classes e DAOs) que vamos usar --%>
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

<%-- Cola o cabeçalho e o menu aqui --%>
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
            <th>Procedimento</th> 
            <th>Data e Hora</th>
            <th>Observações</th>
            <th>Ações</th>
        </tr>
    </thead>
    <tbody>
        <%
            
            //  Prepara os DAOs (quem busca os dados no banco)
            ConsultaDAO dao = new ConsultaDAO();
            PacienteDAO pDao = new PacienteDAO();
            DentistaDAO dDao = new DentistaDAO();
            ProcedimentoDAO procDao = new ProcedimentoDAO();
            
            // Configura como a data vai aparecer (ex: 25/11/2025 14:30)
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

            // Busca a lista de todas as consultas e começa o loop (repetição)
            for (Consulta c : dao.listar()) {
                
                // Usamos os DAOs para buscar o Objeto completo (Nome, etc) baseado nesse ID.
                Paciente p = pDao.buscarPorId(c.getIdPaciente());
                Dentista d = dDao.buscarPorId(c.getIdDentista());
                
                // Busca qual procedimento foi feito nessa consulta específica
                Procedimento proc = procDao.buscarPorIdConsulta(c.getId());
        %>
        
        <tr>
            <td><%= c.getId() %></td>
            
            <td><%= (p != null) ? p.getNome() : "Desconhecido" %></td>
            
            <td><%= (d != null) ? d.getNome() : "Desconhecido" %></td>
            
            <td>
                <%-- Verifica se achou um procedimento vinculado --%>
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
            } // Fim do loop for
        %>
    </tbody>
</table>

<%-- Inclui o rodapé padrão --%>
<jsp:include page="/jsp/includes/footer.jsp" />