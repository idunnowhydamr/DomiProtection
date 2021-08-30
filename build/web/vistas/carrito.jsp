<%-- 
    Document   : carrito.jsp
    Created on : 13/08/2021, 2:49:52 p. m.
    Author     : EMANUEL ORTIZ
--%>


<%@page import="Modelo.CarritoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Comprar Producto</title>
    </head>
    <body>
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
        <div class="container mt-4">
            <h3>Carrito</h3>
            <br>
            <div class="row">
                <div class="col-sm-8">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ITEM</th>
                                <th>NOMBRES</th>
                                <th>DESCRIPCION</th>
                                <th>PRECIO</th>
                                <th>CANTIDAD</th>
                                <th>SUBTOTAL</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                HttpSession sesion = request.getSession();
                                CarritoDAO cdao = new CarritoDAO();

                                if (request.getAttribute("cdao") != null) {
                                    cdao = (CarritoDAO) request.getAttribute("cdao");
                                }
                                int i = 0;
                                while (i < cdao.getSize()) {
                                int item=cdao.getCarrito(i).getItem();
                                int cantidad=0;

                            %>
                            <tr>
                                <td><% out.println(item);%></td>
                                <td><% out.println(cdao.getCarrito(i).getNombre());%></td>
                                <td><% out.println(cdao.getCarrito(i).getDescripcion());%>
                                    <img src="ControladorIMG?id=<%=cdao.getCarrito(i).getIdProducto()%>" width="100" height="100"> 
                                </td>
                                <td><% out.println(cdao.getCarrito(i).getPrecioCompra());%></td>
                                <td>
                                    <input type="hidden" id="idpro" value="<%=cdao.getCarrito(i).getIdProducto()%>">
                                    <input type="number" id="Cantidad" value="<%=cdao.getCarrito(i).getCantidad()%>"  min="1" max="100" step="1" class="form-control text-center "/>
                                </td>
                                <td><% out.println(cdao.getCarrito(i).getSubtotal());%></td>
                                <td>
                                    <input type="hidden" id="pos" value="<%=item%>">
                                    <a href="#" id="btnDelete">Eliminar</a>
                                  
                                </td>
                            </tr>
                            <% i++;
                                }%>
                        </tbody>
                    </table>

                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-header">
                            <h3>Generar Comprar</h3>
                        </div>
                        <div class="card-body">
                            <label>Subtotal:</label>
                            <input type="text" value="$. ${totalPagar}0" readonly="" class="form-control">
                            <label>Descuento:</label>
                            <input type="text" readonly="" class="form-control">
                            <label>Total Pagar:</label>
                            <input type="text" value="$. ${totalPagar}0" readonly="" class="form-control">
                        </div>
                        <div class="card-footer">
                            <a href="#" class="btn btn-info btn-block">Realizar Pago</a>
                            <a href="Controlador?accion=GenerarCompra" class="btn btn-danger btn-block">Generar Compra</a>
                        </div>
                      
                    </div>
                </div>
            </div>
        </div>
                      
        
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js" integrity="sha512-Tn2m0TIpgVyTzzvmxLNuqbSJH3JP8jm+Cy3hvHrW7ndTDcJ1w5mBiksqDBb8GpE2ksktFvDB/ykZ0mDpsZj20w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="./js/funciones.js" type="text/javascript"></script>
    </body>
</html>
