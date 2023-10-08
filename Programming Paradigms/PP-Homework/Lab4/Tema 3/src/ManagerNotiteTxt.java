import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class ManagerNotiteTxt implements IManagerNotite{

    private String _numeDirector;

    public ManagerNotiteTxt(String numeDirector){
        _numeDirector = numeDirector;
    }
    @Override
    public String getNumeDirector(){
        return _numeDirector;
    }
    @Override
    public void setNumeDirector(String numeDirector){
        _numeDirector = numeDirector;
    }

    @Override
    public boolean creareNotita(Notita notita){
        try{
            FileWriter fileW = new FileWriter(_numeDirector + "/" + notita.getTitlu() + ".txt");
            fileW.write(notita.getContinut());
            fileW.close();

            System.out.println("Notita " + notita.getTitlu() + " a fost creata cu succes !");
            return true;
        }
        catch (IOException e){
            System.out.println("Eroare la crearea notitei !");
            e.printStackTrace();
            return false;
        }
    }

    public void afisareNotite(Notite notite){
        if (notite.getListaNotite() != null) {
            for (Notita notita : notite.getListaNotite()) {
                notita.afisareNotita();
            }
        }
        else {
            System.out.println("Lista de notite este goala !");
        }
    }
}
