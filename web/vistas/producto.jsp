<%@page import="Modelo.Carrito"%>
<%@page import="Modelo.ProductoDAO"%>
<%@page import="Config.Conexion"%>
<%@page import="java.awt.Image"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/cssProducto.css" rel="stylesheet" type="text/css"/>
        <title>Productos</title>

    </head>
    <body  class="text-dark" style="font-size:1.2em; font-family: Garamond,serif">    

        <%
            HttpSession sesion = request.getSession();
            //Conectando la Base de datos
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();
            PreparedStatement ps;
            //Emnpezamos Listando los Datos de la Tabla producto
            Statement smt;
            ResultSet rs;
            smt = con.createStatement();
            rs = smt.executeQuery("select * from producto");
            //Creamos la Tabla:     
            ProductoDAO listaP = new ProductoDAO();
            String direccion = "";
            String id = "";
            int contador = 0;
        %>

        <nav class="navbar navbar-expand-lg" style="background:  linear-gradient(rgb(18,111,232) 70%, rgb(9,56,116)); border: solid 1px black;">
            <div class="container-fluid"> 
                <a class="navbar-brand text-dark" href="#">DomiProtection</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active text-dark" aria-current="page" href="./producto.jsp">Principal</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="Controlador?accion=Carrito"><i class="fas fa-cart-plus"></i> <label>${contador}</label></a>
                        </li>
                    </ul>
                </div>
               
                <select class="form-select form-select-sm" aria-label=".form-select-sm example">
                    <option selected>Iniciar Sesion</option>
                    <option value="1">Registrarse</option>
                </select>
            </div>
        </nav>
                        <div>
                            <h3 class="text-center">Bienvenido a DomiProtection</h3>
                        </div>
        <div class="container mt-2 ">
             <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Buscar Producto " aria-label="Search">
                    <button class="btn btn-outline-dark" type="submit">Buscar</button>
                </form>
            <div class="row justify-content-center" >
                <%                            while (rs.next()) {
                        int i = 0;
                        listaP.insertarPrincipioNodo(rs.getInt("idProducto"), rs.getString("Nombres"), rs.getString("Descripcion"), rs.getDouble("Precio"), rs.getInt("Stock"));
                        listaP.insertarFinalNodo(rs.getInt("idProducto"), rs.getString("Nombres"), rs.getString("Descripcion"), rs.getDouble("Precio"), rs.getInt("Stock"));
                %>
                <div class="col-sm-4 card-group text-center mt-2 "  >
                    <div class="card border-dark">
                        <div class="card-header">
                            <% out.println("<label>" + listaP.getProductos(i).getNombres() + "</label>");%>
                        </div>
                        <div class="card-body"  >
                            <% out.println("<i>" + listaP.getProductos(i).getPrecio() + "</i>"); %>
                            <% boolean existe = false;
                                if (request.getAttribute("existe") != null) {
                                    existe = (Boolean) request.getAttribute("existe");
                                }
                                if (existe == false) {
                            %>
                            <img src="./foto.jsp?idproducto=<%=rs.getInt("idProducto")%>" class="img-responsive img-fluid imagen" style="width: 10em; height: 10em" >
                            <%
                            } else {
                            %>
                            <img src="ControladorIMG?id=<%=rs.getInt("idProducto")%>" class="img-responsive img-fluid imagen"  style="width: 10em; height: 10em" >
                            <%  }%>
                        </div>
                        <div class="card-footer">
                            <% out.println("<p>" + listaP.getProductos(i).getDescripcion() + "</p");%>
                            <div>
                                <%
                                    id = String.valueOf(listaP.getProductos(i).getId());
                                    direccion = "../Controlador?accion=AgregarCarrito&id=";
                                    if (request.getAttribute("direccion") != null) {
                                        direccion = (String) request.getAttribute("direccion");
                                    }
                                %>
                                <a href="<%=direccion + id%>"  class="btn btn-outline-info">Agregar carrito de compra</a>
                                <a href="#" class="btn btn-danger">Comprar</a>
                            </div>
                        </div>
                    </div>
                    <%i++;
                        }%>
                </div>

            </div>

        </div>
        <footer class="text-white text-center text-lg-start mt-4" style="background:  linear-gradient(rgb(18,111,232) 70%, rgb(9,56,116)); border: solid 1px black;">
            <!-- Grid container -->
            <div class="container p-4">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                        <h5 class="text-uppercase">Footer Content</h5>

                        <p>
                            Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iste atque ea quis
                            molestias. Fugiat pariatur maxime quis culpa corporis vitae repudiandae aliquam
                            voluptatem veniam, est atque cumque eum delectus sint!
                        </p>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase">Links</h5>

                        <ul class="list-unstyled mb-0">
                            <li>
                                <a href="#!" class="text-white">Link 1</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 2</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 3</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 4</a>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase mb-0">Links</h5>

                        <ul class="list-unstyled">
                            <li>
                                <a href="#!" class="text-white">Link 1</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 2</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 3</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Link 4</a>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->
                </div>
                <!--Grid row-->
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
                © 2020 Copyright:
                <a class="text-white" href="https://mdbootstrap.com/">MDBootstrap.com</a>
            </div>
            <!-- Copyright -->
        </footer>
        <script src="js/jquery.js" type="text/javascript"></script>             
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js" integrity="sha512-Tn2m0TIpgVyTzzvmxLNuqbSJH3JP8jm+Cy3hvHrW7ndTDcJ1w5mBiksqDBb8GpE2ksktFvDB/ykZ0mDpsZj20w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </body>
</html>