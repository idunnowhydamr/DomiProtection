/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

 import Config.Conexion;
import java.sql.ResultSet;
import java.sql.Connection;
 import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.io.OutputStream;
import Config.Conexion;
import java.io.OutputStream;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author diego
 */
public class ProductoDAO {
    //Conectando la Base de datos
            Conexion cn = new Conexion();
            Connection con;
            PreparedStatement ps;
            //Emnpezamos Listando los Datos de la Tabla producto
            Statement smt;
            ResultSet rs;
             private Nodo apuntador = null;
   private Nodo cabeza = null;
    private int size=0;

    public Nodo getApuntador() {
        return apuntador;
    }

    public void setApuntador(Nodo apuntador) {
        this.apuntador = apuntador;
    }

    public Nodo getCabeza() {
        return cabeza;
    }

    public void setCabeza(Nodo cabeza) {
        this.cabeza = cabeza;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    
    
    public void insertarPrincipioNodo(int id, String nombres,String descripcion, double precio, int stock) {
        Nodo newNodo = new Nodo(new Producto(id, nombres,descripcion, precio, stock));
        if (cabeza == null) {
            cabeza = newNodo;
        } else {
            newNodo.siguiente = cabeza;
            cabeza = newNodo;
        }
        size++;
              
    }
    
    public void insertarFinalNodo(int id, String nombres,String descripcion, double precio, int stock) {
        Nodo newNodo = new Nodo(new Producto(id, nombres,descripcion, precio, stock));
      apuntador=null;
        if (cabeza == null) {
            newNodo = cabeza;
        } else {
            apuntador = cabeza;
            while (apuntador.siguiente != null) {
                apuntador = apuntador.siguiente;
            }
            apuntador.siguiente = newNodo;
            size++;    
        }
    }
public void destruir(){
cabeza=null;
apuntador=null;
}
    public Producto getProductos(int index) {
        apuntador = null;
        if (cabeza != null) {
            int contador = 0;
            apuntador = cabeza;
            while (contador < index && apuntador.siguiente != null) {
                apuntador = apuntador.siguiente;
                contador++;
            }
        } else {
            System.out.println("La lista esta vacia");

        }
        return apuntador.dato;
    }
    public Producto listarId(int id){
        
        String sql ="select * from producto where idProducto="+id;
        Producto p=new Producto();
        try{
            con = cn.getConnection();
             smt = con.createStatement();
            rs = smt.executeQuery(sql);
            while(rs.next()){
                p.setId(rs.getInt(1));
                p.setNombres(rs.getString(2));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                p.setStock(rs.getInt(6));
            }
        }catch (Exception e){
        }
        return p;
    }
    public void listarIMG(int idProducto,   HttpServletResponse response) throws SQLException{
         Conexion cn= new Conexion();
            
            Connection con=cn.getConnection();
    PreparedStatement ps;
    ResultSet rs;
    ps = con.prepareStatement("SELECT foto FROM producto where idProducto=?" );
    OutputStream oImage;
    try {
        
        
        ps.setInt(1,idProducto);
        
        rs = ps.executeQuery();
        if (rs.next()) {
            byte barray[] = rs.getBytes(1);
            response.setContentType("image/jpeg");
            oImage = response.getOutputStream();
            oImage.write(barray);
            oImage.flush();
            oImage.close();
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (con != null) {
                con.close();
            }
        } catch (Exception ex) {
             ex.printStackTrace();
        }
    }
    }

    
}

