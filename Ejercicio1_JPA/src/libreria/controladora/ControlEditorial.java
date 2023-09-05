/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package libreria.controladora;

import java.util.Scanner;
import libreria.entidades.Editorial;
import libreria.persistencia.EditorialJpaController;

/**
 *
 * @author Vane Proaño
 */
public class ControlEditorial {
    
    EditorialJpaController editorialjpa = new EditorialJpaController(); // crear tablas
    Scanner leer = new Scanner(System.in);
    
    public Editorial crearEditorial() throws Exception{
        Editorial editorial = new Editorial();
    
        editorial.setNombre(leer.nextLine());
        editorialjpa.create(editorial);
        return editorial;
        
    }
}
