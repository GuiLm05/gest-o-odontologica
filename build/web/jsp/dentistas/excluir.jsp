<%@ page import="model.DAO.DentistaDAO" %>
<%
    String idStr = request.getParameter("id");
    
    if (idStr != null && !idStr.isEmpty()) {
        int id = Integer.parseInt(idStr);
        
        DentistaDAO dao = new DentistaDAO();
        
        if (dao.excluir(id)) {
            // Sucesso: Volta normal
            response.sendRedirect("listar.jsp?msg=sucesso");
        } else {
            // Erro: Volta com um aviso na URL
            response.sendRedirect("listar.jsp?erro=fk_constraint");
        }
    } else {
        response.sendRedirect("listar.jsp");
    }
%>