<%-- 
    Document   : registrarVenta
    Created on : 2/09/2021, 10:02:50 a. m.
    Author     : EMANUEL ORTIZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Ventas</title>
    </head>
    <body>
        <div class="d-flex">
            <div class="col-sm-5">
                <div class="card" style="width: 35rem; box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);">
                    <form action="Controlador1?menu=NuevaVenta" method="POST">
                        <div class="card-body container">

                            <div class="form-group">
                                <label>Datos del Cliente</label>
                            </div>

                            <div class="form-group d-flex row align-items-center">
                                <div class=" d-flex mt-2 col-sm-6" >
                                    <input type="text" name="codigocliente" value="${cl.getDni()}" class="form-control" placeholder="Codigo">
                                    <input type="submit" name="accion" value="BuscarCliente" class="btn btn-outline-info">
                                </div>
                                <div class="col-sm-6 mt-2">
                                    <input type="text" name="nombreCliente" value="${cl.getNombre()}" class="form-control" placeholder="Datos Cliente"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Datos Producto</label>
                            </div>
                            <div class="form-group d-flex row align-items-center">
                                <div class=" d-flex mt-2 col-sm-6" >
                                    <input type="text" name="codigoProducto" class="form-control" placeholder="Codigo">
                                    <input type="submit" name="accion" value="Buscar" class="btn btn-outline-info">
                                </div>
                                <div class="col-sm-6 mt-2">
                                    <input type="text" name="nombreProducto" class="form-control" placeholder="Datos Producto"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Datos Producto</label>
                            </div>
                            <div class="form-group d-flex row align-items-center">
                                <div class=" d-flex mt-2 col-sm-6" >
                                    <input type="text" name="precio" class="form-control" placeholder="/.0.00">

                                </div>
                                <div class="col-sm-3 mt-2">
                                    <input type="number" name="cant" class="form-control" > 
                                </div>
                                <div class="col-sm-3 mt-2">
                                    <input type="text" name="stock" class="form-control" placeholder="Stock"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="submit" name="accion" value="Agregar" class="btn btn-outline-info"> 
                            </div>
                        </div>
                    </form>
                </div>
            </div> 
                <div class="col-sm-7">
                    <div class="card" style="box-shadow: 2px 2px 2px 1px rgba(0, 0, 0, 0.2);">
                        <div class="card-body">
                            <div class="d-flex ml-auto col-sm-6">
                                <label>NumeroSerie</label>
                                <input type="text" name="NroSerie" class="form-control">
                            </div>
                            <br/>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Nro</th>
                                        <th>Codigo</th>
                                        <th>Descripcion</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                        <th>Subtotal</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
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
                        <div class="card-footer">
                            <div>
                                <input type="submit" name="accion" value="Generar Venta" class="btn btn-success">
                                <input type="submit" name="accion" value="Cancelar" class="btn btn-danger">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
