<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.Paciente" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-7"> <div class="card shadow-lg border-0 rounded-3">
                
                <div class="card-header bg-success text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-person-plus-fill me-2"></i> Cadastrar Paciente
                    </h4>
                </div>

                <div class="card-body p-4">

                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            try {
                                String nome = request.getParameter("nome");
                                String cpf = request.getParameter("cpf");
                                String telefone = request.getParameter("telefone");
                                String email = request.getParameter("email");
                                String dataStr = request.getParameter("data_nascimento");
                                String endereco = request.getParameter("endereco");

                                Paciente p = new Paciente();
                                p.setNome(nome);
                                p.setCpf(cpf);
                                p.setTelefone(telefone);
                                p.setEmail(email);
                                p.setEndereco(endereco);

                                if (dataStr != null && !dataStr.isEmpty()) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    p.setDataNascimento(sdf.parse(dataStr));
                                }

                                PacienteDAO dao = new PacienteDAO();
                                if (dao.inserir(p)) {
                                    response.sendRedirect("listar.jsp");
                                } else {
                    %>
                                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                        <div>Erro ao salvar no banco de dados.</div>
                                    </div>
                    <%
                                }
                            } catch (Exception e) {
                    %>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-bug-fill me-2"></i>
                                    <div>Erro técnico: <%= e.getMessage() %></div>
                                </div>
                    <%
                                e.printStackTrace();
                            }
                        }
                    %>

                    <form method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="nome" class="form-control form-control-lg" placeholder="Ex: João da Silva" required>
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
                                    <input type="text" name="telefone" class="form-control" placeholder="(00) 00000-0000" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">E-mail</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope-at"></i></span>
                                <input type="email" name="email" class="form-control" placeholder="cliente@email.com" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Endereço</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" name="endereco" class="form-control" placeholder="Rua, Número, Bairro">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-secondary">Data de Nascimento</label>
                            <input type="date" name="data_nascimento" class="form-control" required>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="listar.jsp" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-arrow-left"></i> Voltar
                            </a>
                            <button type="submit" class="btn btn-success btn-lg px-5">
                                <i class="bi bi-check-circle"></i> Salvar Paciente
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