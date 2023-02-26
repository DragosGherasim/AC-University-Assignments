import java.io.*;

public class Main {
    public static void main(String[] args) throws IOException{
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);

        System.out.println("n = ");
        String str = br.readLine();

        int n = Integer.parseInt(str);

        System.out.printf("The sum of numbers : %d", sumOfNNumbers(n));
    }

    public static int sumOfNNumbers(int n){
        int s = 0;

        for (int i = 1; i <= n; ++i){
            s += i;
        }

        return s;
    }
}
