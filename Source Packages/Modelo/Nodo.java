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

    
    public Nodo(Producto dato) {
        this.dato = dato;
    }
    public Nodo(Carrito dato) {
        this.dato1 = dato;
    }
    
    public Nodo siguiente=null;

    public Nodo() {
    }
  
   public Producto dato;
   public Carrito dato1;
}
