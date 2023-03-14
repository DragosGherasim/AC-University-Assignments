public class IntSet {
    private int[] vect;
    private int top;

    IntSet(int dim){
        vect = new int[dim];

        top = 0;
    }

    public boolean Contains(int val){
        for (int i = 0; i < vect.length; ++i){
            if (val == vect[i]){
                return true;
            }
        }

        return false;
    }

    public void Add(int val) {
        if (top < vect.length) {
            if (!Contains(val)) {
                vect[top++] = val;
            }
        } else {
            System.out.println("Vectorul este full!");
        }
    }

    @Override
    public String toString(){
        String strIntSet = "";

        for (int i=0; i < vect.length; ++i){
            strIntSet += Integer.toString(vect[i]) + " ";
        }

        return strIntSet;
    }
}
