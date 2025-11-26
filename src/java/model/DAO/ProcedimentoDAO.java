/**
 *
 * @author Guilherme Lima
 */
package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Procedimento;

public class ProcedimentoDAO {
    
    // Método 1: Listar todos 
    public List<Procedimento> listar() {
        List<Procedimento> lista = new ArrayList<>();
        String sql = "SELECT * FROM procedimento";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Procedimento p = new Procedimento();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setValor(rs.getDouble("valor"));
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar procedimentos: " + e);
        }
        return lista;
    }

    // Método 2: Buscar pelo ID da Consulta (para a tabela de listagem)
    public Procedimento buscarPorIdConsulta(int idConsulta) {
        Procedimento p = null;
        // O SQL faz um JOIN para achar o procedimento ligado à consulta
        String sql = "SELECT p.* FROM procedimento p " +
                     "INNER JOIN consulta_procedimento cp ON p.id = cp.id_procedimento " +
                     "WHERE cp.id_consulta = ?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idConsulta);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                p = new Procedimento();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setValor(rs.getDouble("valor"));
            }
        } catch (Exception e) {
            System.out.println("Erro ao buscar procedimento da consulta: " + e);
        }
        return p;
    }
    
}