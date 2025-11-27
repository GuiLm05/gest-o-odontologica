<%-- 
    Document   : cadastrar
    Created on : 25 de nov. de 2025
    Author     : Guilherme Lima e Arthur Randis
--%>

<%-- Configurações da Página --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Importações Java --%>
<%@ page import="model.DAO.DentistaDAO" %> <%-- Para salvar no banco --%>
<%@ page import="model.Dentista" %>        <%-- Objeto com os dados --%>

<%-- Includes: Cabeçalho e Menu --%>
<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<%-- 2. ESTRUTURA DO LAYOUT (BOOTSTRAP) --%>
<div class="container">
    <div class="row justify-content-center">
        <%-- Define a largura do card  --%>
        <div class="col-md-9 col-lg-7">

            <%-- O CARTÃO PRINCIPAL --%>
            <div class="card shadow-lg border-0 rounded-3">
                
                <%-- Cabeçalho Azul (Identidade Visual de Dentista) --%>
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-person-badge-fill me-2"></i> Cadastrar Dentista
                    </h4>
                </div>

                <div class="card-body p-4">

                    <%
                        // Só roda se o usuário clicou em Salvar (POST)
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            // Recebe os dados do formulário HTML
                            String nome = request.getParameter("nome");
                            String cro = request.getParameter("cro");
                            String especialidade = request.getParameter("especialidade");
                            String cpf = request.getParameter("cpf");       
                            String telefone = request.getParameter("telefone"); 

                            // Cria o objeto Dentista
                            Dentista d = new Dentista();
                            d.setNome(nome);
                            d.setCro(cro);
                            d.setEspecialidade(especialidade);
                            d.setCpf(cpf);
                            d.setTelefone(telefone);

                            // Chama o DAO para salvar
                            DentistaDAO dao = new DentistaDAO();
                            
                            if (dao.inserir(d)) {
                                // Se salvou, manda pra lista
                                response.sendRedirect("listar.jsp");
                            } else {
                                // Se deu erro, mostra alerta vermelho na tela
                    %>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>Erro ao cadastrar dentista!</div>
                                </div>
                    <%
                            }
                        }
                    %>

                    <%-- 4. FORMULÁRIO HTML --%>
                    <form method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="nome" class="form-control form-control-lg" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-secondary">CPF</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-credit-card-2-front"></i></span>
                                    <input type="text" name="cpf" class="form-control" placeholder="000.000.000-00" maxlength="14" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-secondary">Telefone</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-telephone"></i></span>
                                    <input type="text" name="telefone" class="form-control" placeholder="(00) 99999-9999" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-4">
                                <label class="form-label fw-bold text-secondary">CRO</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-postcard"></i></span>
                                    <input type="text" name="cro" class="form-control" placeholder="12345/SP" required>
                                </div>
                            </div>
                            <div class="col-md-8 mb-4">
                                <label class="form-label fw-bold text-secondary">Especialidade</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-star"></i></span>
                                    <input type="text" name="especialidade" class="form-control" placeholder="Ex: Ortodontia, Clínica Geral" required>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="listar.jsp" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-arrow-left"></i> Voltar
                            </a>
                            <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
                                <i class="bi bi-check-circle"></i> Salvar Dentista
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<br><br>
<jsp:include page="/jsp/includes/footer.jsp" />