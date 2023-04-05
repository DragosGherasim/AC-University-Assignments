import java.util.Scanner;

public class AdaugareInregistrare extends OptiuneMeniu {
    AdaugareInregistrare(String nume){
        super(nume);
    }

    @Override
    public void execute(DataBase db, Scanner scanner) {
        System.out.println("Noua Inregistrare : ");
        System.out.print("May 2019 : ");
        int may19 = scanner.nextInt();

        System.out.print("May 2018 : ");
        int may18 = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Change : ");
        String change = scanner.nextLine();

        System.out.print("Programming Language : ");
        String prgLang = scanner.nextLine();

        System.out.print("Rating : ");
        String rating = scanner.nextLine();

        ProgrammingLanguageTiobe prgL = new ProgrammingLanguageTiobe(may19, may18, change, prgLang,rating);

        db.Insert(prgL);
    }
}
