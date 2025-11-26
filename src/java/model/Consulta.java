/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Guilherme Lima
 */
package model;

import java.util.Date;

public class Consulta {
    
    private int id;
    private int idPaciente;
    private int idDentista;
    private Date dataConsulta;
    private String observacoes;

    // Construtor Vazio
    public Consulta() {
    }

    // Construtor Completo
    public Consulta(int id, int idPaciente, int idDentista, Date dataConsulta, String observacoes) {
        this.id = id;
        this.idPaciente = idPaciente;
        this.idDentista = idDentista;
        this.dataConsulta = dataConsulta;
        this.observacoes = observacoes;
    }

    // --- GETTERS E SETTERS ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public int getIdDentista() {
        return idDentista;
    }

    public void setIdDentista(int idDentista) {
        this.idDentista = idDentista;
    }

    public Date getDataConsulta() {
        return dataConsulta;
    }

    public void setDataConsulta(Date dataConsulta) {
        this.dataConsulta = dataConsulta;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}