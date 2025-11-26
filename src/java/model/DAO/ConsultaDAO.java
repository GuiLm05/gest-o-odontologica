/**
 *
 * @author Guilherme Lima
 */
package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Consulta;

public class ConsultaDAO {

    // --- MÉTODO LISTAR ---
    // Busca todas as consultas do banco para mostrar na tabela
    public List<Consulta> listar() {
        List<Consulta> lista = new ArrayList<>();
        String sql = "SELECT * FROM consulta"; 

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Consulta c = new Consulta();
                // Pega os dados das colunas do banco e coloca no objeto Java
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
    
    // --- MÉTODO EXCLUIR ---
    // Remove uma consulta. Precisa de cuidado especial por causa da chave estrangeira.
    public boolean excluir(int id) {
        // 1. SQL para apagar o vínculo na tabela 'consulta_procedimento' (Filha)
        String sqlLigacao = "DELETE FROM consulta_procedimento WHERE id_consulta=?";
        // 2. SQL para apagar a consulta na tabela 'consulta' (Pai)
        String sqlConsulta = "DELETE FROM consulta WHERE id=?";
        
        Connection conn = null;
        
        try {
            conn = ConectaBanco.conectar();
            
            // INÍCIO DA TRANSAÇÃO: Desliga o salvamento automático.
            // Isso garante que ou apagamos TUDO ou não apagamos NADA.
            conn.setAutoCommit(false); 

            // Passo 1: Apagar da tabela filha
            PreparedStatement stmtLig = conn.prepareStatement(sqlLigacao);
            stmtLig.setInt(1, id);
            stmtLig.executeUpdate();

            // Passo 2: Apagar da tabela pai
            PreparedStatement stmtCons = conn.prepareStatement(sqlConsulta);
            stmtCons.setInt(1, id);
            stmtCons.executeUpdate();
            
            // CONFIRMAÇÃO: Se chegou até aqui sem erro, confirma as alterações no banco.
            conn.commit(); 
            return true;

        } catch (Exception e) {
            // Se deu erro em qualquer passo, desfaz tudo (Rollback)
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { }
            System.out.println("Erro ao excluir consulta: " + e);
            return false;
        } finally {
            // Fecha a conexão manualmente (pois não usamos o try-with-resources ali em cima)
            try { if (conn != null) conn.close(); } catch (SQLException ex) { }
        }
    }

    // --- MÉTODO INSERIR ---
    // Salva a consulta E o procedimento escolhido ao mesmo tempo.
    public boolean inserir(Consulta c, int idProcedimento) {
        // SQL para criar a consulta
        String sqlConsulta = "INSERT INTO consulta (id_paciente, id_dentista, data_consulta, observacoes) VALUES (?,?,?,?)";
        // SQL para vincular o procedimento à consulta criada
        String sqlLigacao = "INSERT INTO consulta_procedimento (id_consulta, id_procedimento, quantidade) VALUES (?,?,?)";
        
        Connection conn = null;
        
        try {
            conn = ConectaBanco.conectar();
            // INÍCIO DA TRANSAÇÃO
            conn.setAutoCommit(false); 

            // 1. Prepara o INSERT da Consulta pedindo para retornar a chave gerada (ID)
            PreparedStatement stmt = conn.prepareStatement(sqlConsulta, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, c.getIdPaciente());
            stmt.setInt(2, c.getIdDentista());
            
            // Verifica se a data existe para converter corretamente
            if (c.getDataConsulta() != null) {
                stmt.setTimestamp(3, new java.sql.Timestamp(c.getDataConsulta().getTime()));
            } else {
                stmt.setNull(3, java.sql.Types.TIMESTAMP);
            }
            stmt.setString(4, c.getObservacoes());
            stmt.executeUpdate();

            // 2. RECUPERAR O ID: Descobre qual número o banco deu para essa consulta nova
            ResultSet rs = stmt.getGeneratedKeys();
            int idConsultaGerada = 0;
            if (rs.next()) {
                idConsultaGerada = rs.getInt(1); // Pega o ID gerado
            }

            // 3. Inserir na tabela de ligação usando o ID recuperado
            PreparedStatement stmtLig = conn.prepareStatement(sqlLigacao);
            stmtLig.setInt(1, idConsultaGerada);
            stmtLig.setInt(2, idProcedimento);
            stmtLig.setInt(3, 1); // Quantidade fixa em 1 por enquanto
            stmtLig.executeUpdate();

            // CONFIRMAÇÃO FINAL
            conn.commit(); 
            return true;

        } catch (Exception e) {
            // Se der erro, desfaz tudo
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { } 
            System.out.println("Erro ao inserir consulta: " + e);
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException ex) { }
        }
    }
}