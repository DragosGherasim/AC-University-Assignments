import java.util.Scanner;

public class OptiuneExit implements OptiuneMeniu{
    private String _numeOptiune;

    public OptiuneExit(String numeOptiune){
        _numeOptiune = numeOptiune;
    }

    @Override
    public String getNumeOptiune(){
        return _numeOptiune;
    }
    @Override
    public void execute(Scanner scanner, Notite notite){
        System.out.println("Ati parasit meniul !");
        System.exit(0);
    }
}
