<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - OdontoSystem</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-login {
            width: 100%;
            max-width: 400px;
            border: none;
            border-radius: 15px;
        }
        .login-header {
            background-color: #0d6efd; /* Azul Primary */
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 20px;
            text-align: center;
        }
        .icon-logo {
            font-size: 3rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <div class="card card-login shadow-lg">
        
        <div class="login-header">
            <div class="icon-logo">
                <i class="bi bi-hospital-fill"></i>
            </div>
            <h3 class="fw-bold">OdontoSystem</h3>
            <p class="mb-0 small opacity-75">Acesso ao Sistema</p>
        </div>

        <div class="card-body p-4">
            
            <% if (request.getParameter("erro") != null) { %>
                <div class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2"></i>
                    <small>Usuário ou senha incorretos.</small>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/jsp/auth/validarlogin.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold">USUÁRIO</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-person-fill"></i></span>
                        <input type="text" name="usuario" class="form-control form-control-lg" placeholder="Ex: admin" required autofocus>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label text-muted small fw-bold">SENHA</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="senha" class="form-control form-control-lg" placeholder="••••••" required>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg shadow-sm">
                        ENTRAR <i class="bi bi-box-arrow-in-right ms-2"></i>
                    </button>
                </div>

            </form>
        </div>
        
        <div class="card-footer text-center py-3 bg-white border-0 rounded-bottom">
            <small class="text-muted">&copy; 2025 Consultório Odontológico</small>
        </div>
    </div>

</body>
</html>