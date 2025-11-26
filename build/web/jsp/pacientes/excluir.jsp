<%-- 
    Document   : excluir
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%@ page import="model.DAO.PacienteDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idStr = request.getParameter("id");
    
    if (idStr != null && !idStr.isEmpty()) {
        int id = Integer.parseInt(idStr);
        
        PacienteDAO dao = new PacienteDAO();
        
        if (dao.excluir(id)) {
            // Sucesso: Volta com mensagem verde
            response.sendRedirect("listar.jsp?msg=sucesso");
        } else {
            // Erro (provavelmente tem consultas): Volta com mensagem vermelha
            response.sendRedirect("listar.jsp?erro=fk_constraint");
        }
    } else {
        response.sendRedirect("listar.jsp");
    }
%>