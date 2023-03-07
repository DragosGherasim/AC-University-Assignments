import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ProcesareFisier {
    public static void main(String[] args) throws IOException {
        // Citire();
        // SumNums();
        LongestMostUsed();
    }

    private static void Citire(){ // 20
        int ch;
        String buf = "";

        FileReader file = null;

        try{
            file = new FileReader("textp1.txt");

            while ((ch = file.read()) != -1){
                buf = buf + (char)ch;
            }

            file.close();
        }

        catch (FileNotFoundException e){
            System.out.println("Fisierul nu a fost gasit");
        }
        catch (IOException e){
            System.out.println("Eroare la citire");
        }

        System.out.println(buf);
    }

    private static void SumNums(){ // 21
        try{
            BufferedReader br = new BufferedReader(new FileReader("textp2.txt"));

            int num = Integer.parseInt(br.readLine());

            String[] strNums = br.readLine().split(" ");
            int[] nums = new int[num];

            for(int i = 0; i < num; ++i){
                nums[i] = Integer.parseInt(strNums[i]);
            }

            br.close();

            int sum = 0;

            for(int el: nums){
                sum += el;
                System.out.print(el + " ");
            }

            System.out.println(sum);
        }

        catch (FileNotFoundException e){
            System.out.println("Fisierul nu a fost gasit");
        }
        catch (IOException e){
            System.out.println("Eroare la citire");
        }
    }

    private static void LongestMostUsed(){ // 22
        int ch;
        String buf = "";

        ArrayList<String> words = new ArrayList<>();
        Map<Character, Integer> hashMap = new HashMap<>();

        FileReader file = null;

        try{
            file = new FileReader("textp3.txt");

            while ((ch = file.read()) != -1){
                if (ch == '\n') {
                    words.add(buf);
                    buf = "";
                    
                    continue;
                }
                else if (ch == '\r') {
                    continue;
                }

                if(hashMap.get((char)ch) == null){
                    hashMap.put((char)ch, 1);
                }
                else {
                    int val = hashMap.get((char) ch);
                    hashMap.put((char) ch, ++val);
                }

                buf = buf + (char)ch;
            }

            words.add(buf);
            
            String maxLengthStr = "";
            
            for(String el: words){
                maxLengthStr = maxLengthStr.length() < el.length() ? el : maxLengthStr;
            }

            System.out.println(maxLengthStr);

            int maxValue = 0;
            for (Integer value : hashMap.values()) {
                maxValue = maxValue < value ? value : maxValue;
            }

            for(Map.Entry<Character, Integer> entry : hashMap.entrySet()){
                if (entry.getValue().equals(maxValue)){
                    System.out.println(entry.getKey());
                    break;
                }
            }

            file.close();
        }

        catch (FileNotFoundException e){
            System.out.println("Fisierul nu a fost gasit");
        }
        catch (IOException e){
            System.out.println("Eroare la citire");
        }
    }
}
