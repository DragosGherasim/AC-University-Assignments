import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class OptiuneCreareNotita implements OptiuneMeniu{
    private String _numeOptiune;

    public OptiuneCreareNotita(String numeOptiune){
        _numeOptiune = numeOptiune;
    }
    @Override
    public String getNumeOptiune(){
        return _numeOptiune;
    }

    @Override
    public void execute(Scanner scanner, Notite notite){
        System.out.print("\n\tCreare notita - Titlu : ");
        scanner.nextLine();
        String titlu = scanner.nextLine();

        String autor = notite.getMgrNotite().getNumeDirector();

        Date data = new Date();
        SimpleDateFormat dataFormat = new SimpleDateFormat("dd.MM.yyyy - HH:mm:ss");
        String dataCreareNotita = dataFormat.format(data);

        System.out.println("\n\tContinut : ");
        String continut = scanner.nextLine();

        Notita notita = new Notita(titlu, autor, dataCreareNotita, continut);

        if (notite.getMgrNotite().creareNotita(notita)){
            notite.adaugareNotita(notita);
        }
    }
}
