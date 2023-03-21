public class Solution {
    public static void main(String[] args){
        SortedVector sortV = new SortedVector();

        sortV.addElement(1);
        sortV.insertElementAt(3, 1);    //sortV.addElement(3);
        sortV.addElement(2);
        sortV.insertElementAt(4, 3);    //sortV.addElement(4);

        System.out.println(sortV);
    }
}
