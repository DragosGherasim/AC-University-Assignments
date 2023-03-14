public class Solution {
    public static void main(String[] args){
        Complex c1 = new Complex(1, 2);
        Complex c2 = new Complex(2, 3);

        c1.adunare(c2);
        System.out.println(c1.toString());

        c1.inmultire(c2);
        System.out.println(c1.toString());

        c1.ridicareLaPutere(2);
        System.out.println(c1.toString());

        System.out.println(c1.equals(c2));
    }
}
