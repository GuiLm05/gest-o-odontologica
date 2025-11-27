<%-- 
    Document   : editar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.Dentista" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<h2>Editar Dentista</h2>

<%
    // Recupera o ID da URL
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    
    DentistaDAO dao = new DentistaDAO();
    
    // Lógica de Atualização (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String cro = request.getParameter("cro");
        String especialidade = request.getParameter("especialidade");
        
        Dentista dAlterado = new Dentista();
        dAlterado.setId(id);
        dAlterado.setNome(nome);
        dAlterado.setCro(cro);
        dAlterado.setEspecialidade(especialidade);
        
        dao.atualizar(dAlterado);
        response.sendRedirect("listar.jsp");
    }
    
    // Carrega os dados atuais para preencher o formulário
    Dentista d = dao.buscarPorId(id);
%>

<form method="post">
    <label>Nome:</label><br>
    <input type="text" name="nome" value="<%= d.getNome() %>" required><br><br>

    <label>CRO:</label><br>
    <input type="text" name="cro" value="<%= d.getCro() %>" required><br><br>

    <label>Especialidade:</label><br>
    <input type="text" name="especialidade" value="<%= d.getEspecialidade() %>" required><br><br>

    <button type="submit">Salvar Alterações</button>
</form>

<br>
<a href="listar.jsp">Cancelar</a>

<jsp:include page="/jsp/includes/footer.jsp" />