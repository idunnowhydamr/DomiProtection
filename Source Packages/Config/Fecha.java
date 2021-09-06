/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Config;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * Es la fecha actualizada para colocar como registro de la venta.
 * @author EMANUEL ORTIZ
 */
public class Fecha {

    private Object fechaSQL;
    private Object vClienteFechaSQL;
     public String getFechaSQL() throws ParseException
    {
        String vFechaOK = new SimpleDateFormat("dd/MM/yyyy").format(this.fechaSQL);
        //
        return vFechaOK;
    }
    //
    public int getAno()
    {
        String vFechaOK = new SimpleDateFormat("yyyy").format(this.vClienteFechaSQL);
        return Integer.parseInt(vFechaOK);
    }
    //
    public int getMes()
    {
        String vFechaOK = new SimpleDateFormat("MM").format(this.vClienteFechaSQL);
        return Integer.parseInt(vFechaOK);
    }
    //
    public int getDia()
    {
        String vFechaOK = new SimpleDateFormat("dd").format(this.vClienteFechaSQL);
        return Integer.parseInt(vFechaOK);
    }
}
