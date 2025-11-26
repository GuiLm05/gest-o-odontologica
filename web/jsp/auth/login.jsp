<%-- 
    Document   : login
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <%-- Garante que o site fique bonito no celular (responsivo) --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - OdontoSystem</title>
    
    <%-- Importando o CSS do Bootstrap  --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Importando os Ícones do Bootstrap (Bonequinho, Cadeado, etc) --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <%-- Estilos Personalizados (CSS) --%>
    <style>
        body {
            /* Cria aquele fundo azul degradê moderno */
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            /* Faz o corpo ocupar 100% da altura da tela */
            height: 100vh;
            /* Comandos Flexbox para centralizar tudo (vertical e horizontal) */
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-login {
            width: 100%;
            max-width: 400px; /* Limita a largura para não ficar esticado em telas grandes */
            border: none;
            border-radius: 15px; /* Arredonda as bordas */
        }
        .login-header {
            background-color: #0d6efd; /* Cor Azul Principal */
            color: white;
            border-radius: 15px 15px 0 0; /* Arredonda só em cima */
            padding: 20px;
            text-align: center;
        }
        .icon-logo {
            font-size: 3rem; /* Tamanho do ícone do hospital */
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <%-- O Cartão (Card) Principal que flutua no meio da tela --%>
    <div class="card card-login shadow-lg">
        
        <%-- 1. CABEÇALHO DO CARD (Parte Azul) --%>
        <div class="login-header">
            <div class="icon-logo">
                <i class="bi bi-hospital-fill"></i> <%-- Ícone de Hospital --%>
            </div>
            <h3 class="fw-bold">OdontoSystem</h3>
            <p class="mb-0 small opacity-75">Acesso ao Sistema</p>
        </div>

        <%-- 2. CORPO DO CARD (Onde digita) --%>
        <div class="card-body p-4">
            
            <%-- Verifica se veio um erro da página de validação --%>
            <% if (request.getParameter("erro") != null) { %>
                <%-- Se tiver erro, mostra esse alerta vermelho --%>
                <div class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2"></i>
                    <small>Usuário ou senha incorretos.</small>
                </div>
            <% } %>

            <%-- FORMULÁRIO DE LOGIN --%>
            <%-- action: Manda os dados para o arquivo que confere a senha (validarlogin.jsp) --%>
            <form action="${pageContext.request.contextPath}/jsp/auth/validarlogin.jsp" method="post">
                
                <%-- Campo Usuário --%>
                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold">USUÁRIO</label>
                    <div class="input-group">
                        <%-- Ícone de pessoa grudado no campo --%>
                        <span class="input-group-text bg-light"><i class="bi bi-person-fill"></i></span>
                        <input type="text" name="usuario" class="form-control form-control-lg" placeholder="Ex: admin" required autofocus>
                    </div>
                </div>

                <%-- Campo Senha --%>
                <div class="mb-4">
                    <label class="form-label text-muted small fw-bold">SENHA</label>
                    <div class="input-group">
                        <%-- Ícone de cadeado grudado no campo --%>
                        <span class="input-group-text bg-light"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="senha" class="form-control form-control-lg" placeholder="••••••" required>
                    </div>
                </div>

                <%-- Botão de Entrar (Azul Grande) --%>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg shadow-sm">
                        ENTRAR <i class="bi bi-box-arrow-in-right ms-2"></i>
                    </button>
                </div>

            </form>
        </div>
        
        <%-- 3. RODAPÉ DO CARD (Copyright) --%>
        <div class="card-footer text-center py-3 bg-white border-0 rounded-bottom">
            <small class="text-muted">&copy; 2025 Consultório Odontológico</small>
        </div>
    </div>

</body>
</html>