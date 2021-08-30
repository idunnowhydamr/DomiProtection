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
 *
 * @author EMANUEL ORTIZ
 */
public class Conexion {

        Connection con;
    String url = "jdbc:mysql://b0zh41zvfavmwpx7ezx0-mysql.services.clever-cloud.com:3306/b0zh41zvfavmwpx7ezx0";
    String Driver = "com.mysql.jdbc.Driver";
    String user = "ulfb0uim57oibj3x";
    String pass = "xdNBbvPA031nImP58VTN";

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
