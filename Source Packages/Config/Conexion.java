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
 * @author ASUS
 */
public class Conexion {

        Connection con;
        //b0zh41zvfavmwpx7ezx0-mysql.services.clever-cloud.com:3306/b0zh41zvfavmwpx7ezx0
//    String url = "jdbc:mysql://bajsdhxtbaix7onvxrku-mysql.services.clever-cloud.com:3306/bajsdhxtbaix7onvxrku";
//    String Driver = "com.mysql.jdbc.Driver";
//    String user = "ux9hx636wwkrxpx5";
//    String pass = "wiugWmqNkazTs6J7xyZn";
//    
    String url = "jdbc:mysql://localhost:3306/domi";
            String Driver = "com.mysql.jdbc.Driver";
            String user = "root";
            String pass = "";

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
