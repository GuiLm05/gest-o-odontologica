<%-- 
    Document   : validarlogin
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Config.ConectaBanco"%>

<%
    // 1. Recebe o que foi digitado no formulário
    String usuarioDigitado = request.getParameter("usuario");
    String senhaDigitada = request.getParameter("senha");

    boolean logado = false;

    // LOGIN SIMPLES 
    // Se o usuário for "admin" e senha "admin", deixa entrar.
    if ("admin".equals(usuarioDigitado) && "admin".equals(senhaDigitada)) {
        logado = true;
    }

    try {
        Connection conn = ConectaBanco.conectar();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM usuario WHERE login=? AND senha=?");
        stmt.setString(1, usuarioDigitado);
        stmt.setString(2, senhaDigitada);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            logado = true;
        }
        conn.close();
    } catch (Exception e) {
        System.out.println("Erro no login: " + e);
    }
   

    // 2. DECISÃO
    if (logado) {
        // SUCESSO: Cria a "Sessão" (O crachá que permite entrar no sistema)
        session.setAttribute("usuarioLogado", usuarioDigitado);
        
        // Manda para a página inicial do sistema
        response.sendRedirect(request.getContextPath() + "/index.html"); 
    } else {
        // FALHA: Volta para o login com aviso de erro
        response.sendRedirect("login.jsp?erro=true");
    }
%>