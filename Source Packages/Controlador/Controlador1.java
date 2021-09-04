/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.Cliente;
import Modelo.ClienteDAO;
import Modelo.Empleado;
import Modelo.EmpleadoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author EMANUEL ORTIZ
 */
@WebServlet(name = "Controlador1", urlPatterns = {"/Controlador1"})
public class Controlador1 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          //Se crean los objetos que se relacionan con la tabla empleado en la db.
    Empleado em=new Empleado();
    EmpleadoDAO emdao=new EmpleadoDAO();
    Cliente cl =new Cliente();
    ClienteDAO cdao=new ClienteDAO();
        String menu = request.getParameter("menu");
         String accion = request.getParameter("accion");
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
                    //Se guarda id del empleado para ser utilizado en el actualizar.
                    Empleado e=emdao.listarId(ide);
                    em.setId(ide);
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
                    
                    emdao.Actualizar(em);
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Delete":
                    ide=Integer.parseInt(request.getParameter("pos"));
                    emdao.delete(ide);
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                default:
                     throw new AssertionError();
            }
           
        } else if (menu.equalsIgnoreCase("Producto")) {
            request.getRequestDispatcher("./vistas/producto.jsp").forward(request, response);
        } else if (menu.equalsIgnoreCase("Cliente")) {
            request.getRequestDispatcher("./vistas/clientes.jsp").forward(request, response);
        } else if (menu.equalsIgnoreCase("NuevaVenta")) {
            switch (accion){
                case "BuscarCliente":
                    String dni=request.getParameter("codigocliente");
                    cl.setDni(dni);
                    cl=cdao.buscar(dni);
                    request.setAttribute("cl", cl);
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
                break;
          
                default:
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
            }
            
        } else if (menu.equalsIgnoreCase("Principal")) {
            request.getRequestDispatcher("./vistas/principal.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
