package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Consulta;

public class ConsultaDAO {

    public List<Consulta> listar() {
        List<Consulta> lista = new ArrayList<>();
        String sql = "SELECT * FROM consulta";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Consulta c = new Consulta();
                c.setId(rs.getInt("id"));
                c.setIdPaciente(rs.getInt("id_paciente"));
                c.setIdDentista(rs.getInt("id_dentista"));
                c.setDataConsulta(rs.getTimestamp("data_consulta"));
                c.setObservacoes(rs.getString("observacoes"));
                lista.add(c);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar consultas: " + e);
        }
        return lista;
    }

    // --- MÉTODO EXCLUIR IMPLEMENTADO ---
    public boolean excluir(int id) {
        // 1. Primeiro removemos a ligação com o procedimento
        String sqlLigacao = "DELETE FROM consulta_procedimento WHERE id_consulta=?";
        // 2. Depois removemos a consulta em si
        String sqlConsulta = "DELETE FROM consulta WHERE id=?";
        
        Connection conn = null;
        
        try {
            conn = ConectaBanco.conectar();
            conn.setAutoCommit(false); // Inicia transação para garantir que apaga os dois

            // Passo 1: Apagar da tabela filha (consulta_procedimento)
            PreparedStatement stmtLig = conn.prepareStatement(sqlLigacao);
            stmtLig.setInt(1, id);
            stmtLig.executeUpdate();

            // Passo 2: Apagar da tabela pai (consulta)
            PreparedStatement stmtCons = conn.prepareStatement(sqlConsulta);
            stmtCons.setInt(1, id);
            stmtCons.executeUpdate();
            
            conn.commit(); // Confirma a exclusão
            return true;

        } catch (Exception e) {
            // Se der erro, desfaz tudo
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { }
            System.out.println("Erro ao excluir consulta: " + e);
            return false;
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException ex) { }
        }
    }

    public boolean inserir(Consulta c, int idProcedimento) {
        String sqlConsulta = "INSERT INTO consulta (id_paciente, id_dentista, data_consulta, observacoes) VALUES (?,?,?,?)";
        String sqlLigacao = "INSERT INTO consulta_procedimento (id_consulta, id_procedimento, quantidade) VALUES (?,?,?)";
        
        Connection conn = null;
        
        try {
            conn = ConectaBanco.conectar();
            conn.setAutoCommit(false); // Inicia Transação

            // Inserir a Consulta
            PreparedStatement stmt = conn.prepareStatement(sqlConsulta, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, c.getIdPaciente());
            stmt.setInt(2, c.getIdDentista());
            
            if (c.getDataConsulta() != null) {
                stmt.setTimestamp(3, new java.sql.Timestamp(c.getDataConsulta().getTime()));
            } else {
                stmt.setNull(3, java.sql.Types.TIMESTAMP);
            }
            stmt.setString(4, c.getObservacoes());
            stmt.executeUpdate();

            // Recuperar o ID gerado
            ResultSet rs = stmt.getGeneratedKeys();
            int idConsultaGerada = 0;
            if (rs.next()) {
                idConsultaGerada = rs.getInt(1);
            }

            // Inserir na tabela de ligação
            PreparedStatement stmtLig = conn.prepareStatement(sqlLigacao);
            stmtLig.setInt(1, idConsultaGerada);
            stmtLig.setInt(2, idProcedimento);
            stmtLig.setInt(3, 1); // Quantidade fixa em 1
            stmtLig.executeUpdate();

            conn.commit(); 
            return true;

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { }
            System.out.println("Erro ao inserir consulta: " + e);
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException ex) { }
        }
    }
}