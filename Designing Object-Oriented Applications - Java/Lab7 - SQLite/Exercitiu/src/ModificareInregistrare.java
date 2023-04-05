import java.util.Scanner;

public class ModificareInregistrare extends OptiuneMeniu{
    ModificareInregistrare(String nume) {
        super(nume);
    }

    @Override
    public void execute(DataBase db, Scanner scanner) {
        scanner.nextLine();

        System.out.print("Numele Limbajului de programare : ");
        String nume = scanner.nextLine();

        System.out.print("Rating : ");
        String rating = scanner.nextLine();

        db.UpdateByRating(nume, rating);
    }
}
