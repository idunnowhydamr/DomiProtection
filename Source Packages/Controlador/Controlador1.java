/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Config.GenerarSerie;
import Modelo.Cliente;
import Modelo.ClienteDAO;
import Modelo.Empleado;
import Modelo.EmpleadoDAO;
import Modelo.Producto;
import Modelo.ProductoDAO;
import Modelo.Venta;
import Modelo.VentaDAO;
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
     //Se crean los objetos que se relacionan con la tabla empleado en la db.
        Empleado em = new Empleado();
        EmpleadoDAO emdao = new EmpleadoDAO();
        //Se crean los objetos que se relacionan con la tabla cliente en la db.
        Cliente cl = new Cliente();
        ClienteDAO cdao = new ClienteDAO();
        //Se crean los objetos que se relacionan con la tabla producto en la db.
        ProductoDAO pdao=new ProductoDAO();
        Producto pd=new Producto();
        //Se crean los objetos que se relacionan con la tabla venta en la db.
        VentaDAO vdao=new VentaDAO();
        Venta vt= new Venta();
        int item=0;
        int cod;
        String descripcion;
        double precio;
        int cant;
        double subtotal;
        double totalPagar;
        String numeroserie;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        int ide = 0;
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
                    String dni = request.getParameter("txtDni");
                    String nom = request.getParameter("txtNombres");
                    String tel = request.getParameter("txtTel");
                    String est = request.getParameter("txtEstado");
                    String user = request.getParameter("txtUsuario");
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
                    ide = Integer.parseInt(request.getParameter("id"));
                    //Se guarda id del empleado para ser utilizado en el actualizar.
                    
                    em = emdao.listarId(ide);
                    
                    request.setAttribute("empleado", em);
                    request.getRequestDispatcher("./vistas/empleado.jsp").forward(request, response);
                    break;
                case "Actualizar":
                    String dni1 = request.getParameter("txtDni");
                    String nom1 = request.getParameter("txtNombres");
                    String tel1 = request.getParameter("txtTel");
                    String est1 = request.getParameter("txtEstado");
                    String user1 = request.getParameter("txtUsuario");
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
                    ide = Integer.parseInt(request.getParameter("pos"));
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
            switch (accion) {
                case "BuscarCliente":
                    String dni = request.getParameter("codigocliente");
                    cl.setDni(dni);
                    cl = cdao.buscar(dni);
                     //Se envian datos para que cargue los productos agregados.
                    request.setAttribute("cl", cl);
                    request.setAttribute("producto", pd);
                    request.setAttribute("vdao", vdao);
                    request.setAttribute("totalpagar", totalPagar);
                    request.setAttribute("nserie", numeroserie);
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
                    break;
                case "BuscarProducto":
                    int id=Integer.parseInt(request.getParameter("codigoproducto"));
                    pd=pdao.listarId(id);
                    //Se envian datos para que cargue los productos agregados.
                    request.setAttribute("cl", cl);
                    request.setAttribute("producto", pd);
                    request.setAttribute("vdao", vdao);
                    request.setAttribute("totalpagar", totalPagar);
                    request.setAttribute("nserie", numeroserie);
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
                    break;
                case "Agregar":
                    totalPagar=0.0;
                    //Se auto incrementa el item cuando se agrega.
                    item=item+1;
                    //Se obtienen los datos requeridos en la vista.
                    cod=pd.getId();
                    descripcion=request.getParameter("nombreproducto");
                    precio=Double.parseDouble(request.getParameter("precio"));
                    cant=Integer.parseInt(request.getParameter("cant"));
                    subtotal=precio*cant;
                    
                    //Se guarda el objeto en una lista simple.
                    if(item==1){
                        vdao.insertarPrincipioNodo(item, cl.getId(), em.getId(),pd.getId(), numeroserie, descripcion, precio, cant, subtotal, totalPagar, "1");
                    }else if(item>1){
                         vdao.insertarPrincipioNodo(item, cl.getId(), em.getId(),pd.getId(), numeroserie, descripcion, precio, cant, subtotal, totalPagar, "1");
                    }
                    //Este for recorre la cantidad de datos que existen en la lista para sacar el total a pagar.
                    for (int i = 0; i < vdao.getSize(); i++) {
                        totalPagar=totalPagar+vdao.getVentas(i).getSubtotal();
                    }
                    
                    //Para que se envie al formulario.
                    request.setAttribute("cl", cl);
                    request.setAttribute("producto", pd);
                    request.setAttribute("totalpagar", totalPagar);
                    request.setAttribute("vdao", vdao);
                    request.setAttribute("nserie", numeroserie);
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
                    break;
                case "GenerarVenta":
                    //Actualizacion de Stock
                    for (int i = 0; i < vdao.getSize(); i++) {
                        Producto pr=new Producto();
                        int cantidad=vdao.getVentas(i).getCantidad();
                        int idproducto=vdao.getVentas(i).getIdproducto();
                        ProductoDAO aO=new ProductoDAO();
                        pr=aO.listarId(idproducto);
                        int sac=pr.getStock()-cantidad;
                        aO.actualizarstock(idproducto, sac);
                    }
                    //Guardar Venta.
                    vt.setIdcliente(cl.getId());
                    vt.setIdempleado(em.getId());
                    vt.setNumserie(numeroserie);
                    vt.setFecha("2021-09-04");
                    vt.setMonto(totalPagar);
                    vt.setEstado("1");  
                    vdao.guardarVenta(vt);                    
                    int idv=Integer.parseInt(vdao.IdVenta());
                    for (int i = 0; i < vdao.getSize(); i++) {
                    vt=new Venta();
                    //Guardar Detalle Venta.
                    vt.setId(idv);
                    vt.setIdproducto(vdao.getVentas(i).getIdproducto());
                    vt.setCantidad(vdao.getVentas(i).getCantidad());
                    vt.setPrecio(vdao.getVentas(i).getPrecio());  
                    }
                    
                    vdao.guardarDetalleVenta(vt);
                    //Para que se envie al formulario.
                    request.setAttribute("cl", cl);
                    request.setAttribute("producto", pd);
                    request.setAttribute("totalpagar", totalPagar);
                    request.setAttribute("vdao", vdao);
                    request.setAttribute("nserie", numeroserie);
                    request.getRequestDispatcher("./vistas/registrarVenta.jsp").forward(request, response);
                    break;
                default:
                    ide = Integer.parseInt(request.getParameter("id"));
                    em.setId(ide);
                    //Generar numero de serie y enviar al formulario
                    numeroserie=vdao.GenerarSerie();
                    if(numeroserie==null){
                        numeroserie="00000001";
                        request.setAttribute("nserie", numeroserie);
                    }else{
                        int incrementar=Integer.parseInt(numeroserie);
                        GenerarSerie gs= new GenerarSerie();
                        numeroserie=gs.NumeroSerie(incrementar);
                        request.setAttribute("nserie", numeroserie);
                    }
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
