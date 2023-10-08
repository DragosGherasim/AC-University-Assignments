import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class OptiuneAfisareNotite implements OptiuneMeniu{
    private String _numeOptiune;

    public OptiuneAfisareNotite(String numeOptiune){
        _numeOptiune = numeOptiune;
    }
    @Override
    public String getNumeOptiune(){
        return _numeOptiune;
    }

    @Override
    public void execute(Scanner scanner, Notite notite){
        notite.getMgrNotite().afisareNotite(notite);
    }
}
