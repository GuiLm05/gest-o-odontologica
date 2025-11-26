<%-- 
    Document   : editar
    Created on : 24 de nov. de 2025
    Author     : Guilherme Lima
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.PacienteDAO" %>
<%@ page import="model.Paciente" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<jsp:include page="/jsp/includes/header.jsp" />
<jsp:include page="/jsp/includes/menu.jsp" />

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-7">

            <div class="card shadow-lg border-0 rounded-3">
                
                <%-- Cabeçalho Verde (Indica Edição) --%>
                <div class="card-header bg-success text-white py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4 class="mb-0 fw-bold">
                            <i class="bi bi-pencil-square me-2"></i> Editar Paciente
                        </h4>
                        <span class="badge bg-white text-success">ID: <%= request.getParameter("id") %></span>
                    </div>
                </div>

                <div class="card-body p-4">

                    <%
                        // 1. Pega o ID da URL
                        String idStr = request.getParameter("id");
                        int id = Integer.parseInt(idStr);
                        
                        PacienteDAO dao = new PacienteDAO();
                        
                        // 2. Processa o formulário (Salvar)
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            try {
                                String nome = request.getParameter("nome");
                                String cpf = request.getParameter("cpf");
                                String telefone = request.getParameter("telefone");
                                String email = request.getParameter("email");
                                String endereco = request.getParameter("endereco");
                                String dataStr = request.getParameter("data_nascimento");
                                
                                Paciente pAlterado = new Paciente();
                                pAlterado.setId(id); // Mantém o mesmo ID
                                pAlterado.setNome(nome);
                                pAlterado.setCpf(cpf);
                                pAlterado.setTelefone(telefone);
                                pAlterado.setEmail(email);
                                pAlterado.setEndereco(endereco);
                                
                                if (dataStr != null && !dataStr.isEmpty()) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    pAlterado.setDataNascimento(sdf.parse(dataStr));
                                }
                                
                                if(dao.atualizar(pAlterado)) {
                                    response.sendRedirect("listar.jsp");
                                } else {
                    %>
                                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                        <div>Erro ao atualizar dados!</div>
                                    </div>
                    <%
                                }
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>Erro: " + e.getMessage() + "</div>");
                            }
                        }
                        
                        // 3. Busca os dados atuais para preencher os campos (value="")
                        Paciente p = dao.buscarPorId(id);
                        
                        // Formata a data para o input HTML (yyyy-MM-dd)
                        String dataFormatada = "";
                        if (p.getDataNascimento() != null) {
                            SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
                            dataFormatada = sdfInput.format(p.getDataNascimento());
                        }
                    %>

                    <form method="post">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" name="nome" class="form-control" value="<%= p.getNome() %>" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-secondary">CPF</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-credit-card-2-front"></i></span>
                                    <input type="text" name="cpf" class="form-control" value="<%= (p.getCpf() != null) ? p.getCpf() : "" %>" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-secondary">Telefone</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-telephone"></i></span>
                                    <input type="text" name="telefone" class="form-control" value="<%= (p.getTelefone() != null) ? p.getTelefone() : "" %>" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">E-mail</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope-at"></i></span>
                                <input type="email" name="email" class="form-control" value="<%= (p.getEmail() != null) ? p.getEmail() : "" %>" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">Endereço</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" name="endereco" class="form-control" value="<%= (p.getEndereco() != null) ? p.getEndereco() : "" %>">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-secondary">Data de Nascimento</label>
                            <input type="date" name="data_nascimento" class="form-control" value="<%= dataFormatada %>" required>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="listar.jsp" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-x-lg"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success btn-lg px-4">
                                <i class="bi bi-save"></i> Salvar Alterações
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