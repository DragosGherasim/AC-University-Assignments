import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
public class Tablouri {
    public static void main(String[] args) throws IOException{
         MinVect();
//         Intersec();
//         Difference();
    }

    private static void MinVect(){ // 1
        Scanner input = new Scanner(System.in);

        int n = input.nextInt();
        int[] vect = new int[n];

        for(int i = 0; i < n; ++i){
            vect[i] = input.nextInt();
        }

        int min = vect[0];
        for(int i=1; i < n; ++i){
            if(min > vect[i]){
                min = vect[i];
            }
        }

        System.out.println(min);
    }

    private static void Intersec(){ // 2
        Scanner input = new Scanner(System.in);

        int n = input.nextInt(), m = input.nextInt();

        int[] a = new int[n], b = new int[m];

        for(int i = 0; i < n; ++i){
            a[i] = input.nextInt();
        }

        for(int i = 0; i < m; ++i){
            b[i] = input.nextInt();
        }

        Map<Integer, Integer> hashMap = new HashMap<>();

        for(int i = 0; i < n; ++i){
            hashMap.put(a[i], i);
        }

        ArrayList intersec = new ArrayList<Integer>();

        for(int i = 0; i < m; ++i){
            if (hashMap.get(b[i]) != null){
                intersec.add(b[i]);
            }
        }

        for (Object elm : intersec){
            System.out.print(elm + " ");
        }
    }

    private static void Difference(){ // 3
        Scanner input = new Scanner(System.in);

        int n = input.nextInt(), m = input.nextInt();

        int[] a = new int[n], b = new int[m];

        for(int i = 0; i < n; ++i){
            a[i] = input.nextInt();
        }

        for(int i = 0; i < m; ++i){
            b[i] = input.nextInt();
        }

        Map<Integer, Integer> hashMap = new HashMap<>();

        for(int i = 0; i < n; ++i){
            hashMap.put(a[i], i);
        }

        ArrayList diff = new ArrayList<Integer>();

        for(int i = 0; i < m; ++i){
            if (hashMap.get(b[i]) == null){
                diff.add(b[i]);
            }
        }

        for (Object elm : diff){
            System.out.print(elm + " ");
        }
    }


}
