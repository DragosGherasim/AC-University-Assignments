import java.util.Scanner;

public class StergereInregistrare extends OptiuneMeniu{
    StergereInregistrare(String nume) {
        super(nume);
    }
    @Override
    public void execute(DataBase db, Scanner scanner) {
        scanner.nextLine();
        System.out.print("Numele limbajului de programare : ");
        String nume = scanner.nextLine();

        db.DeleteByName(nume);
    }
}
