import java.util.Scanner;

public class OrdDescRata extends OptiuneMeniu{
    OrdDescRata(String nume) {
        super(nume);
    }

    @Override
    public void execute(DataBase db, Scanner scanner) {
        db.UpdateByRatingDesc();
    }
}
