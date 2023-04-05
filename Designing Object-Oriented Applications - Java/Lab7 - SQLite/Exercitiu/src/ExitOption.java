import java.util.Scanner;

public class ExitOption extends OptiuneMeniu{
    ExitOption(String nume) {
        super(nume);
    }

    @Override
    public void execute(DataBase db, Scanner scanner) {
        System.out.println("Ati parasit meniul !");
    }
}
