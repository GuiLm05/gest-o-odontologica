<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.DentistaDAO" %>
<%@ page import="model.Dentista" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-7">

            <div class="card shadow-lg border-0 rounded-3">
                
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-person-badge-fill me-2"></i> Cadastrar Dentista
                    </h4>
                </div>

                <div class="card-body p-4">

                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            String nome = request.getParameter("nome");
                            String cro = request.getParameter("cro");
                            String especialidade = request.getParameter("especialidade");
                            // Pegando novos campos
                            String cpf = request.getParameter("cpf");
                            String telefone = request.getParameter("telefone");

                            Dentista d = new Dentista();
                            d.setNome(nome);
                            d.setCro(cro);
                            d.setEspecialidade(especialidade);
                            d.setCpf(cpf);
                            d.setTelefone(telefone);

                            DentistaDAO dao = new DentistaDAO();
                            if (dao.inserir(d)) {
                                response.sendRedirect("listar.jsp");
                            } else {
                    %>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>Erro ao cadastrar dentista!</div>
                                </div>
                    <%
                            }
                        }
                    %>

                    <form method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="nome" class="form-control form-control-lg" placeholder="Dr. Fulano de Tal" required>
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