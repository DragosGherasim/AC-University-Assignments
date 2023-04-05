import java.util.ArrayList;
import java.util.Scanner;

public class CLIMenu {
    private final Scanner scanner;
    ArrayList<OptiuneMeniu> listaOpt;

    public CLIMenu(){
        scanner = new Scanner(System.in);

        listaOpt = new ArrayList<>();
        listaOpt.add(new ExitOption("Exit Option"));
        listaOpt.add(new AdaugareInregistrare("Adaugare Inregistrare"));
        listaOpt.add(new StergereInregistrare("Sterge Inregistrare"));
        listaOpt.add(new ModificareInregistrare("Modificare Inregistrare"));
        listaOpt.add(new OrdDescRata("Ordonare descrescatoare dupa rata"));
        listaOpt.add(new AfisareTabela("Afisare continut tabela"));
    }
    public void ShowMenu(DataBase db){

        while (true){
            System.out.println("""
                    1- Adaugare inregistrare
                    2- Sterge inregistrare
                    3- Modificare inregistrare
                    4- Ordonare descrescatoare dupa rata
                    5- Afisare continut tabela
                    0- Terminare Operatii
                    """);

            System.out.println();

            System.out.print("Alegeti optiunea : ");
            int optiune = scanner.nextInt();

            if (optiune >= 1 && optiune < listaOpt.size()){
                System.out.println("Ati ales optiunea : " + listaOpt.get(optiune).GetNumeOpt());
                listaOpt.get(optiune).execute(db, scanner);
            }
            else if (optiune == 0){
                listaOpt.get(optiune).execute(db, scanner);
                break;
            }
            else{
                System.out.println("Optiunea aleasa nu este una valida, incercati una potrivita !");
            }
        }
    }
}
