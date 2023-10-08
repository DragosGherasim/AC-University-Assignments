import sun.util.resources.ca.CalendarData_ca;

import java.io.File;
import java.io.IOException;

public class Notita {
    private String _titlu;
    private String _autor;
    private String _data;
    private String _continut;

    public Notita(String titlu, String autor, String data, String continut){
        _titlu = titlu;
        _autor = autor;
        _data = data;
        _continut = continut;
    }

    public String getTitlu(){
        return _titlu;
    }

    public String getContinut(){
        return _continut;
    }

    public String getAutor(){
        return _autor;
    }

    public void afisareNotita(){
        System.out.println(_autor + ": " + _titlu + " -> " + _data + "\n" + _continut + "\n");
    }
}
