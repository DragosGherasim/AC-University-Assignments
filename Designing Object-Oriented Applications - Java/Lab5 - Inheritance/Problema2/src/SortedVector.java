import java.util.Comparator;
import java.util.Vector;

public class SortedVector extends Vector {
    @Override
    public void addElement(Object obj){
        super.addElement(obj);
        super.sort(Comparator.comparingInt((Object obj2) -> (Integer) obj2));
    }

    @Override
    public void insertElementAt(Object obj, int indx){
        super.insertElementAt(obj, indx);
        super.sort((Object obj1, Object obj2) -> (Integer)obj1 - (Integer) obj2);
    }
}
