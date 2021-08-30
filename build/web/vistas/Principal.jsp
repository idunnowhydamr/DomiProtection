<%-- 
    Document   : Principal
    Created on : 30/08/2021, 2:01:04 a. m.
    Author     : EMANUEL ORTIZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet">   
        <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Principal</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-info">

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a style="margin-left: 5px;border:none" class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a style="margin-left: 5px;border:none" class="nav-link" href="#">Producto</a>
                    </li>
                    <li class="nav-item">
                        <a style="margin-left: 5px;border:none" class="nav-link" href="#">Empleado</a>
                    </li>
                    <li class="nav-item">
                        <a style="margin-left: 5px;border:none" class="nav-link disabled" href="#">Clientes</a>
                    </li>
                </ul>
                
            </div>
            <div class="dropdown text-center">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${usuario.getNom()}
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        
                       
                        <a class="dropdown-item" href="#">
                             <img style="width:6em;height:6em" class="img-responsive" src="./img/user.jpeg" alt=""/>
                        </a>
                        <a class="dropdown-item" href="#">${usuario.getUser()}</a>
                        <a class="dropdown-item" href="#">usuario@gmail.com</a>
                        <div class="dropdown-driver"></div>
                        <form accion="Validar" method="POST">
                            <button name="accion" value="Salir" class="dropdown-item" >Salir</button>
                        </form>
                    </div>
                </div>
        </nav>
        <script src="js/jquery.js" type="text/javascript"></script>             
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
