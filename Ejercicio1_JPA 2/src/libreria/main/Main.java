/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package libreria.main;

import java.util.Scanner;
import libreria.controladora.ControlAutor;
import libreria.controladora.ControlEditorial;
import libreria.controladora.ControlLibro;
import libreria.persistencia.EditorialJpaController;
import libreria.persistencia.LibroJpaController;

/**
 *
 * @author Vane Proaño
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {
         //crear las tablas con las controladoras en sql
         Scanner leer = new Scanner (System.in);
 ControlAutor controlautor = new ControlAutor();
        System.out.println("ingrese el nombre del autor que quiere eliminar");
        String eliminado= leer.nextLine();
 controlautor.eliminarAutor(eliminado);
//  controlautor.crearAutor();
       // ControlLibro controlibro = new ControlLibro();
        
       /* LibroJpaController libro = new LibroJpaController();
        libro.corregir();
        EditorialJpaController editorial = new EditorialJpaController();
        editorial.corregir();
        esto es un metodo para corregir el dato de alta que estaba en false y se le actualizo a true
        */
        
//        controlibro.crearLibro();
       //ControlEditorial controleditorial = new ControlEditorial();
     

            
        }
   
    }
    

