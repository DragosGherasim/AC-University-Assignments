import java.util.ArrayList;
public class Cinema {
    private ArrayList<Film> _listaFilme;
    private CashingMethod _metodaIncasare;


    Cinema(CashingMethod metodaIncasare){
        _listaFilme = new ArrayList<>();

        _listaFilme.add(new Film("Avatar 2", 35));
        _listaFilme.add(new Film("Spider-man 3", 30));
        _listaFilme.add(new Film("Iron man 2", 25));


        _metodaIncasare = metodaIncasare;
    }

    public ArrayList<Film> getListaFilme(){
        return _listaFilme;
    }
    public CashingMethod getMetodaIncasare(){
        return _metodaIncasare;
    }
}
