public class Solution {
    public static void main(String[] args){
        Stiva st = new Stiva(3);

        st.Push(1);
        st.Push(2);
        st.Push(3);
        st.Push(4);

        System.out.println(st.Pop());
        System.out.println(st.Pop());
        System.out.println(st.Pop());
        System.out.println(st.Pop());

        System.out.println(st.isEmpty());
    }
}
