//import java.util.List;

public class Main {
    public static void main(String[] args){
        DataBase tiobe = new DataBase();

        /*List<ProgrammingLanguageTiobe> list = new ArrayList<>();
        list.add(new ProgrammingLanguageTiobe(1, 1, "-0.38%", "Java", "16.005%"));
        list.add(new ProgrammingLanguageTiobe(2, 2, "+0.24%", "C", "14.243%"));
        list.add(new ProgrammingLanguageTiobe(3, 3, "+0.43%", "C++", "8.095%"));
        list.add(new ProgrammingLanguageTiobe(4, 4, "+2.64%", "Python", "7.830%"));

        list.forEach(tiobe::Insert);*/

        /* CLIMenu menu = new CLIMenu();
        menu.ShowMenu(tiobe);
        tiobe.DropTable();*/

        JTableTiobe tiobeTable = new JTableTiobe(tiobe);
    }
}
