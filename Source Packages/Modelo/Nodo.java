/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;



/**
 *
 * @author diego
 */
public class Nodo {

    //Se crea el nodo de tipo Producto.
    public Nodo(Producto dato) {
        this.dato = dato;
    }
    //Se crea el nodo de tipo Carrito.
    public Nodo(Carrito dato) {
        this.dato1 = dato;
    }
    //Se crea el nodo de tipo Empleado.
    public Nodo(Empleado dato) {
        this.dato2 = dato;
    }
    public Nodo siguiente=null;

    public Nodo() {
    }
  //Se declaran obejetos de cada tipo para guardar las propiedades de las mismas.
   public Producto dato;
   public Carrito dato1;
   public Empleado dato2;
}
