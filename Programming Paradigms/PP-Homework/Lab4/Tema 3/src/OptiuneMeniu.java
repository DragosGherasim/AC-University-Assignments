import java.util.Scanner;

public interface OptiuneMeniu {
    String getNumeOptiune();

    void execute(Scanner scanner, Notite notite);
}
