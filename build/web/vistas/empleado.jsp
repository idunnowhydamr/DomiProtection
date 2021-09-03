<%-- 
    Document   : empleado
    Created on : 2/09/2021, 10:02:16 a. m.
    Author     : EMANUEL ORTIZ
--%>

<%@page import="Modelo.Empleado"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Config.Conexion"%>
<%@page import="Modelo.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Empleado</title>
    </head>
    <body>
        <!-- Se muestra la informacion del usuario -->
        <div class="d-flex">
            <div class="card col-sm-6">
                <div class="card-body">
                    <form action="Controlador?menu=Empleado" method="POST">
                        <div class="form-group">
                            <label>Identificacion</label>
                            <input type="text" name="txtDni" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text" name="txtNombres" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Telefono</label>
                            <input type="text" name="txtTel" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Estado</label>
                            <input type="text" name="txtEstado" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Usuario</label>
                            <input type="text" name="txtUsuario" class="form-control">
                        </div>
                        <input class="btn btn-danger mt-2" type="submit" name="accion" value="Agregar">
                    </form>
                </div>
            </div>
            <div class="col-sm-4">
                <table class="table table-hover">
                    <thead>
                        <%
                            //Conectando la Base de datos
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();
            PreparedStatement ps;
            //Emnpezamos Listando los Datos de la Tabla producto
            Statement smt;
            ResultSet rs;
            smt = con.createStatement();
            rs = smt.executeQuery("select * from empleado");
            
            //Creamos la Tabla:     
            EmpleadoDAO listaE= new EmpleadoDAO();
            
                                
                                while (rs.next()) {
                                int i = 0;
                                //Se crea el objeto empleado para que guarde los datos de cada empleado temporalmente.
            Empleado em = new Empleado();
              em.setId(rs.getInt(1));
                em.setDni(rs.getString(2));
                em.setNom(rs.getString(3));
                em.setTel(rs.getString(4));
                em.setEstado(rs.getString(5));
                em.setUser(rs.getString(6));
                listaE.insertarPrincipioNodo(em.getId(),em.getDni(),em.getNom(),em.getTel(),em.getEstado(),em.getUser());
            listaE.insertarFinalNodo(em.getId(),em.getDni(),em.getNom(),em.getTel(),em.getEstado(),em.getUser());

                            %>
                        <tr>
                            <th><% out.println(listaE.getEmpleados(i).getId());%></th>
                            <th><% out.println(listaE.getEmpleados(i).getNom());%></th>
                            <th><% out.println(listaE.getEmpleados(i).getTel());%></th>
                            <th><% out.println(listaE.getEmpleados(i).getEstado());%></th>
                            <th><% out.println(listaE.getEmpleados(i).getUser());%></th>
                            <th>ACCIONES</th>
                        </tr>
                        <%i++;}%>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
