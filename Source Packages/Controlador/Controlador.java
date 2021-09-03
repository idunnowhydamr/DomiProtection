/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Config.Fecha;
import Modelo.Carrito;
import Modelo.CarritoDAO;
import Modelo.Cliente;
import Modelo.Compra;
import Modelo.CompraDAO;
import Modelo.Empleado;
import Modelo.EmpleadoDAO;
import Modelo.Pago;
import Modelo.Producto;
import Modelo.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author EMANUEL ORTIZ
 */
@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {
    //Se crean los objetos que se relacionan con la tabla empleado en la db.
    Empleado em=new Empleado();
    EmpleadoDAO emdao=new EmpleadoDAO();
    
    Fecha fecha = new Fecha();
    ProductoDAO pdao = new ProductoDAO();
    CarritoDAO cdao = new CarritoDAO();
    Producto p = new Producto();
    Carrito car = new Carrito();
    int item = 0;
    int idp;
    double totalPagar = 0.0;
    int cantidad = 1;
    String direccion = "";
    boolean existe = true;//Direccion
    boolean carritoVacio = false;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        //Se declaran las variables que van a recibir los parametros.
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        HttpSession sesion = request.getSession();
        int ide = 0 ;
        //Casos con el parametro menu(Para el empleado).
        if (menu.equalsIgnoreCase("Empleado")) {
            //Se crea un switch para recibir las acciones que se envien desde la pantalla de empleado.
            switch (accion) {
                case "Listar":
                    //Redirige al empleado a la lista de empleados.
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Agregar":
                    //Recibe los datos que se envian desdce el formulario de empleado.
                    String dni=request.getParameter("txtDni");
                    String nom=request.getParameter("txtNombres");
                    String tel=request.getParameter("txtTel");
                    String est=request.getParameter("txtEstado");
                    String user=request.getParameter("txtUsuario");
                    //Se guarda temporalmente la informacion en el objeto empleado para enviarlo a la db.
                    em.setDni(dni);
                    em.setNom(nom);
                    em.setTel(tel);
                    em.setEstado(est);
                    em.setUser(user);
                    //Se agrega empleado a la db.
                    emdao.Agregar(em);
                    //Redirige al empleado a la lista de empleados.
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Editar":
                    ide=Integer.parseInt(request.getParameter("id"));
                    Empleado e=emdao.listarId(ide);
                    request.setAttribute("empleado", e);
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Actualizar":
                    String dni1=request.getParameter("txtDni");
                    String nom1=request.getParameter("txtNombres");
                    String tel1=request.getParameter("txtTel");
                    String est1=request.getParameter("txtEstado");
                    String user1=request.getParameter("txtUsuario");
                    //Se guarda temporalmente la informacion en el objeto empleado para enviarlo a la db.
                    em.setDni(dni1);
                    em.setNom(nom1);
                    em.setTel(tel1);
                    em.setEstado(est1);
                    em.setUser(user1);
                    //Se agrega empleado a la db.
                    em.setId(ide);
                    emdao.Actualizar(em);
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Delete":
                    break;
                default:
                     
            }
           
        } else if (menu.equalsIgnoreCase("Producto")) {
            request.getRequestDispatcher("./vistas/producto.jsp").forward(request, response);
        } else if (menu.equalsIgnoreCase("Cliente")) {
            request.getRequestDispatcher("./vistas/clientes.jsp").forward(request, response);
        } else if (menu.equalsIgnoreCase("NuevaVenta")) {
            request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
        } else if (menu.equalsIgnoreCase("Principal")) {
            request.getRequestDispatcher("./vistas/principal.jsp").forward(request, response);
        }
        //Casos con el parametro accion(Para los clientes).
        switch (accion) {
            case "Comprar":
                idp = Integer.parseInt(request.getParameter("id"));

                p = pdao.listarId(idp);
                item = item + 1;
                car.setItem(item);
                car.setIdProducto(p.getId());
                car.setNombre(p.getNombres());
                car.setDescripcion(p.getDescripcion());
                car.setPrecioCompra(p.getPrecio());
                car.setCantidad(cantidad);
                car.setSubtotal(p.getPrecio() * cantidad);
                existe = true;
                if (item == 1) {
                    cdao.insertarPrincipioNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                } else if (item > 1) {
                    cdao.insertarFinalNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                }
                for (int i = 0; i < cdao.getSize(); i++) {
                    totalPagar = totalPagar + cdao.getCarrito(i).getSubtotal();
                }
                request.setAttribute("totalPagar", totalPagar);
                request.setAttribute("cdao", cdao);
                request.setAttribute("contador", cdao.getSize());
                request.getRequestDispatcher("./vistas/carrito.jsp").forward(request, response);
                break;
            case "AgregarCarrito":
                int pos = 0;
                cantidad = 1;
                idp = Integer.parseInt(request.getParameter("id"));
                p = pdao.listarId(idp);
                if (cdao.getSize() > 0) {
                    for (int i = 0; i < cdao.getSize(); i++) {
                        if (idp == cdao.getCarrito(i).getIdProducto()) {
                            pos = i;
                        }
                    }
                    if (idp == cdao.getCarrito(pos).getIdProducto()) {
                        cantidad = cdao.getCarrito(pos).getCantidad() + cantidad;
                        double subtotal = cdao.getCarrito(pos).getPrecioCompra() * cantidad;
                        cdao.getCarrito(pos).setCantidad(cantidad);
                        cdao.getCarrito(pos).setSubtotal(subtotal);
                    } else {
                        if (carritoVacio && cdao.getSize() == 0) {
                            item = 1;
                        } else {
                            item = item + 1;
                            carritoVacio = false;
                        }
                        direccion = "./Controlador?accion=AgregarCarrito&id=";
                        car.setItem(item);
                        car.setIdProducto(p.getId());
                        car.setNombre(p.getNombres());
                        car.setDescripcion(p.getDescripcion());
                        car.setPrecioCompra(p.getPrecio());
                        car.setCantidad(cantidad);
                        car.setSubtotal(p.getPrecio() * cantidad);
                        if (item == 1) {
                            cdao.insertarPrincipioNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                        } else if (item > 1) {
                            cdao.insertarFinalNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                        }
                    }
                } else {
                    if (carritoVacio && cdao.getSize() == 0) {
                        item = 1;
                    } else {
                        item = item + 1;
                        carritoVacio = false;
                    }
                    direccion = "./Controlador?accion=AgregarCarrito&id=";
                    car.setItem(item);
                    car.setIdProducto(p.getId());
                    car.setNombre(p.getNombres());
                    car.setDescripcion(p.getDescripcion());
                    car.setPrecioCompra(p.getPrecio());
                    car.setCantidad(cantidad);
                    car.setSubtotal(p.getPrecio() * cantidad);
                    if (item == 1) {
                        cdao.insertarPrincipioNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                    } else if (item > 1) {
                        cdao.insertarFinalNodo(car.getItem(), car.getIdProducto(), car.getDescripcion(), car.getNombre(), car.getPrecioCompra(), car.getCantidad(), car.getSubtotal());
                    }

                }

                existe = true;

                request.setAttribute("contador", cdao.getSize());
                request.setAttribute("direccion", direccion);
                request.setAttribute("existe", existe);

                request.getRequestDispatcher("./index.jsp").forward(request, response);
                break;
            case "Delete":
                int posicion = Integer.parseInt(request.getParameter("pos"));
                for (int i = 0; i < cdao.getSize(); i++) {
                    if (cdao.getCarrito(i).getItem() == posicion) {
                        carritoVacio = cdao.Eliminar(posicion);
                        cdao.getCarrito(i).setItem(cdao.getCarrito(i).getItem() - 1);
                        if (i == cdao.getSize() - 1) {
                            item = cdao.getCarrito(i).getItem();
                        } else if (cdao.getSize() == 0) {
                            item = 1;
                        }
                    }
                }

                break;
            case "ActulizarCantidad":
                int idpro = Integer.parseInt(request.getParameter("idp"));
                int cant = Integer.parseInt(request.getParameter("Cantidad"));
                for (int i = 0; i < cdao.getSize(); i++) {
                    if (cdao.getCarrito(i).getIdProducto() == idpro) {
                        cdao.getCarrito(i).setCantidad(cant);
                        double st = cdao.getCarrito(i).getPrecioCompra() * cant;
                        cdao.getCarrito(i).setSubtotal(st);
                    }
                }

                request.getRequestDispatcher("Controlador?accion=Carrito").forward(request, response);

                break;
            case "Carrito":
                totalPagar = 0.0;

                for (int i = 0; i < cdao.getSize(); i++) {
                    totalPagar = totalPagar + cdao.getCarrito(i).getSubtotal();
                }
                request.setAttribute("cdao", cdao);

                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("./vistas/carrito.jsp").forward(request, response);
                break;
            case "GenerarCompra":
                Cliente cliente = new Cliente();
                cliente.setId(1);
                CompraDAO dao = new CompraDAO();
                Compra compra = new Compra(cliente, 1, "", totalPagar, "Cancelado", cdao);
                int res = dao.GenerarCompra(compra);
                if (res != 0 && totalPagar > 0) {
                    request.getRequestDispatcher("./vistas/mensaje.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("./vistas/error.jsp").forward(request, response);
                }
                break;

            default:

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Controlador.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Controlador.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
