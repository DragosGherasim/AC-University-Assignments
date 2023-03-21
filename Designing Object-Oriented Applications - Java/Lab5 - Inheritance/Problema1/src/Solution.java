public class Solution {
    public static void main(String[] args){
        /*SetAsVector1<Integer> setV = new SetAsVector1<>();

        System.out.println(setV.add(1));
        System.out.println(setV.add(1));

        System.out.println(setV.add(2));
        System.out.println(setV.contains(2));

        System.out.println(setV.add(3));
        System.out.println(setV.remove((Integer) 2));
        System.out.println(setV.remove(1));
        System.out.println(setV.toString());*/

        SetAsVector2<Integer> setV = new SetAsVector2<>();

        System.out.println(setV.add(1));
        System.out.println(setV.add(1));

        System.out.println(setV.add(2));
        System.out.println(setV.contains(2));

        System.out.println(setV.add(3));
        System.out.println(setV.remove(1));
        System.out.println(setV.toString());
    }
}
