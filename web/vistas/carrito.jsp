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
        <nav class="navbar navbar-expand-lg " style="background:  linear-gradient(rgb(18,111,232) 70%, rgb(9,56,116)); border: solid 1px black;">
            <div class="container-fluid"> 

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active text-light" aria-current="page" id="headerdomiprotection" href="./index.jsp">DomiProtection</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="Controlador?accion=Carrito"><i class="fas fa-cart-plus"></i> <label>${contador}</label></a>
                        </li>
                    </ul>
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
                                int item = cdao.getCarrito(i).getItem();
                                int cantidad = 0;

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

    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> 
    <script src="./js/funciones.js" type="text/javascript"></script>
</body>
</html>
