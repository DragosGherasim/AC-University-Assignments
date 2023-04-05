import java.util.Scanner;

public abstract class OptiuneMeniu{
    private final String numeOpt;

   OptiuneMeniu(String nume){
        numeOpt = nume;
    }

    public String GetNumeOpt(){
        return numeOpt;
   }
    public abstract void execute(DataBase db, Scanner scanner);
}
