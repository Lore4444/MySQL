/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package libreria.controladora;

import java.util.Scanner;
import libreria.entidades.Libro;
import libreria.persistencia.LibroJpaController;

/**
 *
 * @author Vane Proaño
 */
public class ControlLibro {

    LibroJpaController librojpa = new LibroJpaController(); // crear las tablas
    ControlAutor ca = new ControlAutor();
    ControlEditorial ce = new ControlEditorial();
    Scanner leer = new Scanner(System.in);

    public Libro crearLibro() throws Exception {
        Libro libro = new Libro();
        System.out.println("Ingrese el nombre del libro: ");
        libro.setTitulo(leer.nextLine());
        System.out.println("Ingrese el año del libro: ");
        libro.setAnio(leer.nextInt());
        System.out.println("Ingrese el nombre del autor: ");
        libro.setAutor(ca.crearAutor());
        System.out.println("Ingrese el nombre de la editorial: ");
        libro.setEditorial(ce.crearEditorial());
        librojpa.create(libro);

        return libro;
    }

}
