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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Paciente;

public class PacienteDAO {

    // Listar (Select)
    public List<Paciente> listar() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM paciente";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Paciente p = new Paciente();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setCpf(rs.getString("cpf"));
                p.setTelefone(rs.getString("telefone"));
                p.setEmail(rs.getString("email"));
                p.setDataNascimento(rs.getDate("data_nascimento"));
                p.setEndereco(rs.getString("endereco")); // Campo novo
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar pacientes: " + e);
        }
        return lista;
    }

    // Buscar por ID (Select where ID)
    public Paciente buscarPorId(int id) {
        Paciente p = null;
        String sql = "SELECT * FROM paciente WHERE id=?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                p = new Paciente();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setCpf(rs.getString("cpf"));
                p.setTelefone(rs.getString("telefone"));
                p.setEmail(rs.getString("email"));
                p.setDataNascimento(rs.getDate("data_nascimento"));
                p.setEndereco(rs.getString("endereco"));
            }

        } catch (Exception e) {
            System.out.println("Erro ao buscar paciente: " + e);
        }
        return p;
    }

    // Inserir (Insert)
    public boolean inserir(Paciente p) {
        String sql = "INSERT INTO paciente (nome, cpf, telefone, email, data_nascimento, endereco) VALUES (?,?,?,?,?,?)";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNome());
            stmt.setString(2, p.getCpf());
            stmt.setString(3, p.getTelefone());
            stmt.setString(4, p.getEmail());
            
            if (p.getDataNascimento() != null) {
                stmt.setDate(5, new java.sql.Date(p.getDataNascimento().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            stmt.setString(6, p.getEndereco()); 

            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao inserir paciente: " + e);
            e.printStackTrace();
            return false;
        }
    }

    // Atualizar (Update)
    public boolean atualizar(Paciente p) {
        // Atualiza todos os campos, inclusive endereço
        String sql = "UPDATE paciente SET nome=?, cpf=?, telefone=?, email=?, data_nascimento=?, endereco=? WHERE id=?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNome());
            stmt.setString(2, p.getCpf());
            stmt.setString(3, p.getTelefone());
            stmt.setString(4, p.getEmail());

            if (p.getDataNascimento() != null) {
                stmt.setDate(5, new java.sql.Date(p.getDataNascimento().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            stmt.setString(6, p.getEndereco());
            
            stmt.setInt(7, p.getId());

            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar paciente: " + e);
            return false;
        }
    }

    // Excluir (Delete)
    public boolean excluir(int id) {
        String sql = "DELETE FROM paciente WHERE id=?";

        try (Connection conn = ConectaBanco.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Erro ao excluir paciente: " + e);
            return false;
        }
    }
}