import java.util.Scanner;

public class AfisareTabela extends OptiuneMeniu{
    AfisareTabela(String nume) {
        super(nume);
    }

    @Override
    public void execute(DataBase db, Scanner scanner) {
        db.SelectAll();
    }
}
