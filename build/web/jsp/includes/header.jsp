<%-- 
    Document   : header
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%-- Configura a página para aceitar acentos e caracteres especiais --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <%-- Viewport: Faz o site se ajustar bem em celulares e tablets --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>OdontoSystem</title>
    
    <%-- BOOTSTRAP CSS --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <%-- BOOTSTRAP ICONS: Traz a biblioteca de ícones --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <%-- CSS PERSONALIZADO: ajustes finos --%>
    <style>
        body { 
            background-color: #f4f6f9; /* Fundo cinza bem clarinho (profissional) */
        }
        
        /* Classe para animar os Cards do Painel */
        .card-hover {
            transition: transform 0.2s, box-shadow 0.2s; /* Suaviza a animação */
            border: none;
        }
        
        /* O que acontece quando passa o mouse em cima do card */
        .card-hover:hover {
            transform: translateY(-5px); /* Sobe um pouquinho */
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; /* Cria uma sombra */
            cursor: pointer; /* Muda o cursor para mãozinha */
        }
        
        /* Tamanho dos ícones grandes do painel */
        .icon-box {
            font-size: 3rem;
            margin-bottom: 10px;
        }
    </style>
</head>

<body> 
<%-- A tag BODY abre aqui, mas só fecha no footer.jsp! --%>