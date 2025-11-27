/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Guilherme Lima e Arthur Randis
 */
package model;

import java.util.Date;

public class Paciente {
    
    // Atributos 
    private int id;
    private String nome;
    private String cpf;
    private String telefone;
    private String email;
    private Date dataNascimento;
    private String endereco; 

    // Construtor Vazio 
    public Paciente() {
    }

    // Método get set

    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; // 
    }

    public String getNome() { 
        return nome; 
    }
    public void setNome(String nome) { 
        this.nome = nome; 
    }

    public String getCpf() { 
        return cpf; 
    }
    public void setCpf(String cpf) { 
        this.cpf = cpf; 
    }

    public String getTelefone() { 
        return telefone; 
    }
    public void setTelefone(String telefone) { 
        this.telefone = telefone; 
    }

    public String getEmail() { 
        return email; 
    }
    public void setEmail(String email) { 
        this.email = email; 
    }

    public Date getDataNascimento() { 
        return dataNascimento; 
    }
    public void setDataNascimento(Date dataNascimento) { 
        this.dataNascimento = dataNascimento; 
    }

    public String getEndereco() { 
        return endereco; 
    }
    public void setEndereco(String endereco) { 
        this.endereco = endereco; 
    }
}
