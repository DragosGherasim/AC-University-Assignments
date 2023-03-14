public class Solution {
    public static void main(String[] args){
        IntSet set = new IntSet(3);

        set.Add(1);
        set.Add(2);
        set.Add(3);

        System.out.println(set.Contains(2));

        System.out.println(set.toString());
    }
}
