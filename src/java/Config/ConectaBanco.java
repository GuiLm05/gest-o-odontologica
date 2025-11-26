/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;
import java.sql.*;
/**
 *
 * @author Guilherme Lima
 */
public class ConectaBanco {
    public static Connection conectar() throws ClassNotFoundException {
        // Abre uma conexão
        Connection conn = null; 
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestao_odont","root","tricolor23");            
        }catch(SQLException ex){
                System.out.println("Erro - SQL: " + ex);
        }
        return conn;
    }
}

