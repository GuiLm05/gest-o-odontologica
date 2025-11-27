<%-- 
    Document   : excluir
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%@ page import="model.DAO.ConsultaDAO" %>
<%
    // 1. Pega o ID que veio no link
    String idStr = request.getParameter("id");
    
    if (idStr != null && !idStr.isEmpty()) {
        int id = Integer.parseInt(idStr);
        
        // 2. Chama o DAO para apagar do banco
        ConsultaDAO dao = new ConsultaDAO();
        dao.excluir(id);
    }
    
    // 3. Volta para a lista
    response.sendRedirect("listar.jsp");
%>