<%-- 
    Document   : cadastrar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%-- Configurações da Página --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Importações necessárias para o funcionamento do Java --%>
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

<%-- Inclui o cabeçalho e menu padrão do sistema --%>
<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<h2>Agendar Nova Consulta</h2>

<%
    // Só executa este bloco se o usuário clicou no botão "Agendar" (enviou o formulário via POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // 1. Captura os dados enviados pelo formulário HTML
            // Integer.parseInt converte o texto "1" para o número inteiro 1
            int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
            int idDentista = Integer.parseInt(request.getParameter("idDentista"));
            
            // Captura o procedimento escolhido
            int idProcedimento = Integer.parseInt(request.getParameter("idProcedimento"));
            
            // Captura a data como texto e as observações
            String dataStr = request.getParameter("data");
            String observacoes = request.getParameter("observacoes");

            // 2. Converte a data do formato HTML (texto) para Date do Java
            // O formato 'yyyy-MM-dd'T'HH:mm' é o padrão do input type="datetime-local"
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dataConsulta = sdf.parse(dataStr);

            // 3. Cria o objeto Consulta e preenche com os dados
            Consulta c = new Consulta();
            c.setIdPaciente(idPaciente);
            c.setIdDentista(idDentista);
            c.setDataConsulta(dataConsulta);
            c.setObservacoes(observacoes); // Salva as anotações

            // 4. Chama o DAO para salvar no banco de dados
            ConsultaDAO dao = new ConsultaDAO();
            
            // O método inserir agora recebe a consulta E o ID do procedimento para vincular
            if (dao.inserir(c, idProcedimento)) {
                // Se salvou com sucesso, redireciona para a lista de agendamentos
                response.sendRedirect("listar.jsp");
            } else {
                // Se deu erro no banco, mostra mensagem
                out.println("<p style='color:red'>Erro ao gravar no banco!</p>");
            }
        } catch (Exception e) {
            // Captura erros gerais (ex: erro de conversão de dados) e mostra na tela
            out.println("<p style='color:red'>Erro: " + e.getMessage() + "</p>");
            e.printStackTrace(); // Imprime o erro detalhado no console do servidor
        }
    }
%>

<%-- --- FORMULÁRIO HTML --- --%>
<form method="post">
    
    <label>Paciente:</label><br>
    <select name="idPaciente" required style="width: 300px;">
        <option value="">Selecione...</option>
        <%
            // Código Java misturado para preencher o <select> com dados do banco
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

<%-- Inclui o rodapé padrão --%>
<jsp:include page="/jsp/includes/footer.jsp" />