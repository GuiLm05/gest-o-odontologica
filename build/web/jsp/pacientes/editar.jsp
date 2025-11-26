<%-- 
    Document   : editar
    Created on : 24 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.Paciente" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<h2>Editar Paciente</h2>

<%
    // 1. Recupera o ID da URL (ex: editar.jsp?id=5)
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    
    PacienteDAO dao = new PacienteDAO();
    
    // 2. Lógica de ATUALIZAR (Quando clica em Salvar)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            String endereco = request.getParameter("endereco");
            String dataStr = request.getParameter("data_nascimento");
            
            Paciente pAlterado = new Paciente();
            pAlterado.setId(id); // Importante: Manter o mesmo ID
            pAlterado.setNome(nome);
            pAlterado.setCpf(cpf);
            pAlterado.setTelefone(telefone);
            pAlterado.setEmail(email);
            pAlterado.setEndereco(endereco);
            
            if (dataStr != null && !dataStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                pAlterado.setDataNascimento(sdf.parse(dataStr));
            }
            
            if(dao.atualizar(pAlterado)) {
                response.sendRedirect("listar.jsp");
            } else {
                out.println("<p style='color:red'>Erro ao atualizar!</p>");
            }
        } catch (Exception e) {
             out.println("<p style='color:red'>Erro: " + e.getMessage() + "</p>");
        }
    }
    
    // 3. Carregar os dados atuais para preencher o formulário
    Paciente p = dao.buscarPorId(id);
    
    // Formatar data para exibir no input date (yyyy-MM-dd)
    String dataFormatada = "";
    if (p.getDataNascimento() != null) {
        SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
        dataFormatada = sdfInput.format(p.getDataNascimento());
    }
%>

<form method="post">
    <label>Nome:</label><br>
    <input type="text" name="nome" value="<%= p.getNome() %>" required style="width: 300px;"><br><br>

    <label>CPF:</label><br>
    <input type="text" name="cpf" value="<%= (p.getCpf() != null) ? p.getCpf() : "" %>" required><br><br>

    <label>Telefone:</label><br>
    <input type="text" name="telefone" value="<%= (p.getTelefone() != null) ? p.getTelefone() : "" %>" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" value="<%= (p.getEmail() != null) ? p.getEmail() : "" %>" required style="width: 300px;"><br><br>
    
    <label>Endereço:</label><br>
    <input type="text" name="endereco" value="<%= (p.getEndereco() != null) ? p.getEndereco() : "" %>" style="width: 300px;"><br><br>

    <label>Data de Nascimento:</label><br>
    <input type="date" name="data_nascimento" value="<%= dataFormatada %>" required><br><br>

    <button type="submit">Salvar Alterações</button>
</form>

<br>
<a href="listar.jsp">Cancelar</a>

<jsp:include page="/jsp/includes/footer.jsp" />