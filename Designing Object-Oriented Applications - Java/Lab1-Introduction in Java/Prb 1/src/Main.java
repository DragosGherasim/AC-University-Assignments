import java.util.Scanner;
import java.io.IOException;
import java.lang.Math;
public class Main {
    public static void main(String[] args) throws IOException{
        countPrimeDivisible();
    }

    public static void countPrimeDivisible() {
       Scanner input = new Scanner(System.in);

       int n, p, count_prime = 0, count_divisible = 0;
       System.out.print("n = ");
       n = input.nextInt();

       System.out.print("p = ");
       p = input.nextInt();

       for(int i = 0; i < n; ++i){
           int num;

           System.out.print("num = ");
           num = input.nextInt();

           if (num == 1 || num == 2 || num == 3){
               ++count_prime;
           }
           else {
               for (int j = 2; j < Math.sqrt(num); ++j) {
                   if (num % j == 0) {
                       break;
                   }

                   ++count_prime;
               }
           }
           if (num % p == 0) {
               ++count_divisible;
           }
       }

       System.out.printf("\nThe number of prime numbers : %d", count_prime);
       System.out.printf("\nThe number of divisible numbers by p : %d", count_divisible);
    }
}
