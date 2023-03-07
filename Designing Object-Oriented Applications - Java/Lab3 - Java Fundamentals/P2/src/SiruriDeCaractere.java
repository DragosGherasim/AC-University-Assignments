import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class SiruriDeCaractere {
    public static void main(String[] args) throws IOException {
        NrDeAparitii();
//        InlocuireAparitii();
//        NewSplit();
    }

    private static void NrDeAparitii() throws IOException { // 13
        BufferedReader br = new BufferedReader(
                new InputStreamReader(System.in)
        );

        String str1 = br.readLine(), str2 = br.readLine();
        int contor = 0;

        while(str1.indexOf(str2) >= 0){
            contor++;

            int indx = str1.indexOf(str2) + str2.length();
            str1 = str1.substring(indx, str1.length());
        }

        System.out.println(contor);
    }

    private static void InlocuireAparitii() throws IOException{ // 14
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String str = br.readLine();
        char ch = (char)br.read();

        while (str.indexOf(ch) >= 0){
            str = str.replace(ch, '*');

            str = str.substring(str.indexOf(ch) + 1, str.length());
        }

        System.out.println(str);
    }

    private static void NewSplit() throws IOException{ // 15
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String str = br.readLine();

        ArrayList<String> words = new ArrayList<>();

        int indx = str.indexOf(' ');
        while(indx >= 0){
            words.add(str.substring(0, indx));

            str = str.substring(indx+1, str.length());

            indx = str.indexOf(' ');
        }

        for(Object elm : words){
            System.out.println(elm + " ");
        }
    }
}
