import java.util.ArrayList;

public class Notite {
    private ArrayList<Notita> _listaNotite;
    private final IManagerNotite _mgrNotite;

    public Notite(IManagerNotite mgrNotite){
        _listaNotite = new ArrayList<>();

        _mgrNotite = mgrNotite;
    }
    public IManagerNotite getMgrNotite(){
        return _mgrNotite;
    }

    public ArrayList<Notita> getListaNotite(){
        return _listaNotite;
    }

    public void adaugareNotita(Notita notita){
        for(Notita not : _listaNotite){
            if (not.getTitlu().equals(notita.getTitlu())){
                System.out.println("Notita curenta a modificat notita " + not.getTitlu() + " deja creata !");
                return;
            }
        }

        _listaNotite.add(notita);
    }
}
