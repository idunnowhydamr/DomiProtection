/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Config;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *Aqui se hace la conexion, se hace con el localhost y con clever cloud
 * Se pone como comentario la de clever cloud, debido a fallo en las peticiones.
 * @author EMANUEL ORTIZ
 */
public class Conexion {

        Connection con;
        //b0zh41zvfavmwpx7ezx0-mysql.services.clever-cloud.com:3306/b0zh41zvfavmwpx7ezx0
    String url = "jdbc:mysql://b5ozfrxqr4anyvls1tc4-mysql.services.clever-cloud.com:20850/b5ozfrxqr4anyvls1tc4";
    String Driver = "com.mysql.jdbc.Driver";
    String user = "ulsveschpzosw2dy";
    String pass = "Jhknjm7hWVHqJUj5cDI";
    
//    String url = "jdbc:mysql://localhost:3306/prueba";
//            String Driver = "com.mysql.jdbc.Driver";
//            String user = "root";
//            String pass = "";

    public Connection getConnection() {
        try {

            if (this.con == null) {
                Class.forName(Driver);
                con = DriverManager.getConnection(url, user, pass);
                PreparedStatement ps;
            }

        } catch (Exception e) {
            System.out.println("The exception raised is:" + e);
            return null;
        }
        return con;
    }
    
    

}
