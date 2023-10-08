import java.util.Scanner;

public class Cumparator {
    private String _nume;
    private String _numeFilm;

    private PaymentMethod _metodaPlata;

    Cumparator(String nume, String numeFilm, PaymentMethod metodaPlata){
        _nume = nume;
        _numeFilm = numeFilm;
        _metodaPlata = metodaPlata;
    }

    public String getNumeFilm(){
        return _numeFilm;
    }
    public boolean plataFilm(double pret){
        if (_metodaPlata.pay(pret)){
            return true;
        }
        return false;
    }
}
