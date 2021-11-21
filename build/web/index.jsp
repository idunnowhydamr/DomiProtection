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
        <link href="css/Producto.css" rel="stylesheet"/>
        
        <title>Productos</title>
        <style>
            .flip-card {
  background-color: transparent;
  width: 300px;
  height: 300px;
  perspective: 1000px;
}

.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: center;
  transition: transform 0.6s;
  transform-style: preserve-3d;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
}

.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}

.flip-card-front {
  background-color: #bbb;
  color: black;
}

.flip-card-back {
  background-color: #2980b9;
  color: white;
  transform: rotateY(180deg);
}
</style>
    </head>
    <!<!--Se coloca el tipo de letra desde aca, para que cuando 
    cambie por el controlador, lleve estos cambios-->
    <body  class="text-dark">    
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

        <! <!-- comment -->
        <nav class="navbar navbar-expand-lg" style="background-color: #bff2eb">
            <a class="navbar-brand text-dark" href="../PPI(1)/index.jsp">DomiProtection</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link text-dark" href="Controlador?accion=Carrito&id=0"><i class="fas fa-cart-plus"></i> <label>${contador}</label></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-dark" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Sesión
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="./vistas/validarCliente.jsp">Cliente</a>
                            <a class="dropdown-item" href="./vistas/registrarCliente.jsp">Registrarse</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="./vistas/validarEmpleado.jsp">Empleado</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#">Bienvenidos a DomiProtection</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control me-2" type="text" name="txtbuscar">
                    <input class="btn btn-outline-dark" type="submit" value="Buscar">
                </form>
            </div>
        </nav>

<h1>Card Flip with Text</h1>
<h3>Hover over the image below:</h3>

<div class="flip-card">
  <div class="flip-card-inner">
    <div class="flip-card-front">
      <img src="img_avatar.png" alt="Avatar" style="width:300px;height:300px;">
    </div>
    <div class="flip-card-back">
      <h1>John Doe</h1> 
      <p>Architect & Engineer</p> 
      <p>We love that guy</p>
    </div>
  </div>
</div>
        <%
            //Se crea peticion para buscar el producto.
            String nombuscar = request.getParameter("txtbuscar");
            if (nombuscar != null) {
                con = cn.getConnection();
                smt = con.createStatement();
                rs = smt.executeQuery("select * from producto where Nombres LIKE" + "'%" + nombuscar + "%'");
            } else {
                System.err.print("Error");
            }
        %>
        <div class="row justify-content-center">
            <%                            while (rs.next()) {
                    int i = 0;
                    listaP.insertarPrincipioNodo(rs.getInt("idProducto"), rs.getString("Nombres"), rs.getString("Descripcion"), rs.getDouble("Precio"), rs.getInt("Stock"));
                    listaP.insertarFinalNodo(rs.getInt("idProducto"), rs.getString("Nombres"), rs.getString("Descripcion"), rs.getDouble("Precio"), rs.getInt("Stock"));
            %>
            <div class="col-sm-4 card-group text-center m-2 p-4"  >
                <div class="card border-dark" >
                    <div class="card-header" >
                        <% out.println("<label>" + listaP.getProductos(i).getNombres() + "</label>");%>

                    </div>
                    <div class="card-body" >
                        <% out.println("<label>Codigo: " + listaP.getProductos(i).getId() + "</label>");%>

                        <% boolean existe = false;
                            if (request.getAttribute("existe") != null) {
                                existe = (Boolean) request.getAttribute("existe");
                            }
                            if (existe == false) {
                        %>
                        <img src="vistas/foto.jsp?idproducto=<%=rs.getInt("idProducto")%>" class="img-responsive img-fluid imagen" style="width: 9em; height: 9em" >
                        <%
                        } else {
                        %>
                        <img src="ControladorIMG?id=<%=rs.getInt("idProducto")%>" class="img-responsive img-fluid imagen"  style="width: 9em; height: 9em" >
                        <%  }%>
                        <% out.println("<i>Precio: " + listaP.getProductos(i).getPrecio() + "</i>"); %>
                    </div>

                    <div class="card-footer">
                        <% out.println("<p>" + listaP.getProductos(i).getDescripcion() + "</p");%>
                        <div>
                            <%
                                id = String.valueOf(listaP.getProductos(i).getId());
                                direccion = "Controlador?accion=AgregarCarrito&id=";
                                if (request.getAttribute("direccion") != null) {
                                    direccion = (String) request.getAttribute("direccion");
                                }
                            %>
                            <a href="<%=direccion + id + "&idc=" + 0%>"  class="btn btn-outline-info">Agregar carrito de compra</a>
                        </div>
                    </div>
                </div>
                <%i++;
                    }%>
            </div>

        </div>
        <div class="btn-whatsapp">
            <a href="https://api.whatsapp.com/send?phone=+573504689979" target="_blank">
                <img src="./img/whatsapp.png" class="btn-whatsapp"/>
            </a>
        </div>
    </div>
    <div class="container my-5">
        <!-- Footer -->
        <footer
            class="text-center text-lg-start text-dark"
            style="background-color:  #bff2eb"
            >
            <!-- Grid container -->
            <div class="container p-2 pb-0">
                <!-- Section: Links -->
                <section class="">
                    <!--Grid row-->
                    <div class="row">
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">
                                Company name
                            </h6>
                            <p>
                                Here you can use rows and columns to organize your footer
                                content. Lorem ipsum dolor sit amet, consectetur adipisicing
                                elit.
                            </p>
                        </div>
                        <!-- Grid column -->

                        <hr class="w-100 clearfix d-md-none" />

                        <!-- Grid column -->
                        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Products</h6>
                            <p>
                                <a class="text-white">MDBootstrap</a>
                            </p>
                            <p>
                                <a class="text-white">MDWordPress</a>
                            </p>
                            <p>
                                <a class="text-white">BrandFlow</a>
                            </p>
                            <p>
                                <a class="text-white">Bootstrap Angular</a>
                            </p>
                        </div>
                        <!-- Grid column -->

                        <hr class="w-100 clearfix d-md-none" />

                        <!-- Grid column -->
                        <hr class="w-100 clearfix d-md-none" />

                        <!-- Grid column -->
                        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Contact</h6>
                            <p><i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
                            <p><i class="fas fa-envelope mr-3"></i> info@gmail.com</p>
                            <p><i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                            <p><i class="fas fa-print mr-3"></i> + 01 234 567 89</p>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                            <h6 class="text-uppercase mb-4 font-weight-bold">Follow us</h6>

                            <!-- Facebook -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #3b5998"
                                href="#!"
                                role="button"
                                ><i class="fab fa-facebook-f"></i
                                ></a>

                            <!-- Twitter -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #55acee"
                                href="#!"
                                role="button"
                                ><i class="fab fa-twitter"></i
                                ></a>

                            <!-- Google -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #dd4b39"
                                href="#!"
                                role="button"
                                ><i class="fab fa-google"></i
                                ></a>

                            <!-- Instagram -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #ac2bac"
                                href="#!"
                                role="button"
                                ><i class="fab fa-instagram"></i
                                ></a>

                            <!-- Linkedin -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #0082ca"
                                href="#!"
                                role="button"
                                ><i class="fab fa-linkedin-in"></i
                                ></a>
                            <!-- Github -->
                            <a
                                class="btn btn-primary btn-floating m-1"
                                style="background-color: #333333"
                                href="#!"
                                role="button"
                                ><i class="fab fa-github"></i
                                ></a>
                        </div>
                    </div>
                    <!--Grid row-->
                </section>
                <!-- Section: Links -->
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div
                class="text-center p-3"
                style="background-color: rgba(0, 0, 0, 0.2)"
                >
                © 2020 Copyright:
                <a class="text-white" href="https://mdbootstrap.com/"
                   >MDBootstrap.com</a
                >
            </div>
            <!-- Copyright -->
        </footer>
        <!-- Footer -->
    </div>
    <!-- End of .container -->
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> 
</body>
</html>