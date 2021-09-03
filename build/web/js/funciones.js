$(document).ready(function () {
       $('.dropdown-toggle').dropdown();
    $("tr #btnDelete").click(function () {
        var pos = $(this).parent().find("#pos").val();
        swal({
            title: "Estas Seguro De Eliminar?",
            text: "Un producto eliminado, puedes agregar de nuevo!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
                .then((willDelete) => {
                    if (willDelete) {
                        eliminar(pos);
                        swal("El producto ha sido eliminado!", {
                            icon: "success",
                        }).then((willDelete) =>{
                            if(willDelete){
                                 parent.location.href = "Controlador?accion=Carrito";
                            }
                        });
                    } else {
                        swal("Registro no eliminado!");
                    }
                });
        
    });
    
    $("tr #btnBorrar").click(function () {
        var pos = $(this).parent().find("#pos").val();
        swal({
            title: "Estas Seguro De Eliminar?",
            text: "Un producto eliminado, puedes agregar de nuevo!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
                .then((willDelete) => {
                    if (willDelete) {
                        eliminarEmpleado(pos);
                        swal("El producto ha sido eliminado!", {
                            icon: "success",
                        }).then((willDelete) =>{
                            if(willDelete){
                                 parent.location.href = "./vistas/principal.jsp";
                            }
                        });
                    } else {
                        swal("Registro no eliminado!");
                    }
                });
        
    });
    function eliminar(pos) {
        var url = "Controlador?accion=Delete";
        $.ajax({
            type: 'POST',
            url: url,
            data: "pos=" + pos,
            success: function (data, textStatus, jqXHR) {

                
               
            }
        });
    }
     function eliminarEmpleado(pos) {
        var url = "Controlador?menu=Empleado&accion=Delete";
        $.ajax({
            type: 'POST',
            url: url,
            data: "pos=" + pos,
            success: function (data, textStatus, jqXHR) {

                
               
            }
        });
    }

    $("tr #Cantidad").click(function () {
        var idp = $(this).parent().find("#idpro").val();
        var cantidad = $(this).parent().find("#Cantidad").val();
        var url = "Controlador?accion=ActulizarCantidad";
        $.ajax({
            type: 'POST',
            url: url,
            data: "idp=" + idp + "&Cantidad=" + cantidad,
            success: function (data, textStatus, jqXHR) {

                location.href = "Controlador?accion=Carrito";

            }
        });
    });
});



