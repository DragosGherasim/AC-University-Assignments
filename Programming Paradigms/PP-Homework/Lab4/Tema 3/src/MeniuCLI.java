import java.util.ArrayList;
import java.util.Scanner;

public class MeniuCLI {
    private final Scanner _scanner;
    private final ArrayList<OptiuneMeniu> _listaOptiuniMeniu;

    public MeniuCLI(Scanner scanner){
        _scanner = scanner;

        _listaOptiuniMeniu = new ArrayList<>();
        _listaOptiuniMeniu.add(new OptiuneConectare("Conectare la cont"));
        _listaOptiuniMeniu.add(new OptiuneCreareNotita("Creare notita"));
        _listaOptiuniMeniu.add(new OptiuneAfisareNotite("Afisare notite"));
        _listaOptiuniMeniu.add(new OptiuneExit("Exit meniu"));
    }

    public void afisareMeniu(Notite notite){
        System.out.println("\n\t\tBine ati revenit !");

        System.out.println("\n\t1. " + _listaOptiuniMeniu.get(0).getNumeOptiune());
        System.out.println("\t2. " + _listaOptiuniMeniu.get(_listaOptiuniMeniu.size()-1).getNumeOptiune());

        System.out.print("\nAlegeti optiunea : ");
        int optiuneaAleasa = _scanner.nextInt();

        if (optiuneaAleasa == 1) {
            _listaOptiuniMeniu.get(0).execute(_scanner, notite);

            while (true) {
                for (int i = 1; i < _listaOptiuniMeniu.size(); ++i) {
                    System.out.println((i) + ". " + _listaOptiuniMeniu.get(i).getNumeOptiune());
                }

                System.out.print("\nAlegeti optiunea : ");
                optiuneaAleasa = _scanner.nextInt();

                if (optiuneaAleasa >= 1 && optiuneaAleasa <= _listaOptiuniMeniu.size()-1){
                    _listaOptiuniMeniu.get(optiuneaAleasa).execute(_scanner, notite);
                }
                else{
                    System.out.println("Alegerea optiunii este invalida. Incercati din nou !");
                }
            }
        }
        else{
            _listaOptiuniMeniu.get(1).execute(_scanner, notite);
        }
    }
}
