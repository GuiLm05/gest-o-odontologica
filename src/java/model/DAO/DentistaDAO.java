/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Guilherme Lima e Arthur Randis
 */
package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Dentista;

public class DentistaDAO {

    // Listar
    public List<Dentista> listar() {
        List<Dentista> lista = new ArrayList<>();
        String sql = "SELECT * FROM dentista";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Dentista d = new Dentista();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setCro(rs.getString("cro"));
                d.setEspecialidade(rs.getString("especialidade"));
                d.setCpf(rs.getString("cpf"));
                d.setTelefone(rs.getString("telefone"));
                lista.add(d);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar dentistas: " + e);
        }
        return lista;
    }

    // Buscar no ID (Usado no Editar)
    public Dentista buscarPorId(int id) {
        Dentista d = null;
        String sql = "SELECT * FROM dentista WHERE id=?";
        
        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                d = new Dentista();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setCro(rs.getString("cro"));
                d.setEspecialidade(rs.getString("especialidade"));
                d.setCpf(rs.getString("cpf"));
                d.setTelefone(rs.getString("telefone"));
            }
        } catch (Exception e) {
            System.out.println("Erro ao buscar dentista: " + e);
        }
        return d;
    }

    // Inserir
    public boolean inserir(Dentista d) {
        String sql = "INSERT INTO dentista (nome, cro, especialidade, cpf, telefone) VALUES (?,?,?,?,?)";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, d.getNome());
            stmt.setString(2, d.getCro());
            stmt.setString(3, d.getEspecialidade());
            stmt.setString(4, d.getCpf());
            stmt.setString(5, d.getTelefone());
            
            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao inserir dentista: " + e);
            return false;
        }
    }

    // Atualizar (Necessário para o Editar funcionar)
    public boolean atualizar(Dentista d) {
        String sql = "UPDATE dentista SET nome=?, cro=?, especialidade=?, cpf=?, telefone=? WHERE id=?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, d.getNome());
            stmt.setString(2, d.getCro());
            stmt.setString(3, d.getEspecialidade());
            stmt.setString(4, d.getCpf());
            stmt.setString(5, d.getTelefone());
            stmt.setInt(6, d.getId());

            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar dentista: " + e);
            return false;
        }
    }

    // Excluir
    public boolean excluir(int id) {
        String sql = "DELETE FROM dentista WHERE id=?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao excluir dentista: " + e);
            return false;
        }
    }
}