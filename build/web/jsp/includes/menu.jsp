<%-- 
    Document   : menu
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Proteção de login
    if (session.getAttribute("usuarioLogado") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/auth/login.jsp");
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-5 shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.html">
        <i class="bi bi-hospital-fill"></i> OdontoSystem
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/index.html">Início</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/jsp/agendamentos/listar.jsp">Agendamentos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/jsp/pacientes/listar.jsp">Pacientes</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/jsp/dentistas/listar.jsp">Dentistas</a>
        </li>
        <li class="nav-item ms-3">
          <a class="btn btn-danger btn-sm mt-1" href="${pageContext.request.contextPath}/jsp/auth/logout.jsp">
              <i class="bi bi-box-arrow-right"></i> Sair
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">