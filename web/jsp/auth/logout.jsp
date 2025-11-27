<%-- 
    Document   : logout
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Destrói a sessão
    session.invalidate();

    //  Redireciona o usuário de volta para a tela de login
    response.sendRedirect("login.jsp");
%>