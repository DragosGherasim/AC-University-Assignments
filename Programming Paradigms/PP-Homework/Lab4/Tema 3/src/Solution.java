import java.util.Scanner;

public class Solution {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        Notite notite = new Notite(new ManagerNotiteTxt(""));

        MeniuCLI meniu = new MeniuCLI(scanner);

        meniu.afisareMeniu(notite);
    }
}
