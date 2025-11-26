<%-- 
    Document   : logout
    Created on : 25 de nov. de 2025, 11:00:02
    Author     : Guilherme Lima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Destrói a sessão
    session.invalidate();

    //  Redireciona o usuário de volta para a tela de login
    response.sendRedirect("login.jsp");
%>