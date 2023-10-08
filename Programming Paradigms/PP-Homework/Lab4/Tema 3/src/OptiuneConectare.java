import java.util.Scanner;

public class OptiuneConectare implements OptiuneMeniu{
    private String _numeOptiune;

    public OptiuneConectare(String numeOptiune){
        _numeOptiune = numeOptiune;
    }

    @Override
    public String getNumeOptiune(){
        return _numeOptiune;
    }
    @Override
    public void execute(Scanner scanner, Notite notite){
        System.out.print("\n\tVa rugam sa va conectati la contul dumneavoastra ! \nUsername : ");
        scanner.nextLine();
        String userName = scanner.nextLine();

        User user = new User(userName);

        notite.getMgrNotite().setNumeDirector(user.getName());
    }
}
