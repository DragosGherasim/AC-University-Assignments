import java.util.Vector;

public class SetAsVector2<T> {
    private Vector<T> setV;

    SetAsVector2(){
        setV = new Vector<T>();
    }
    public boolean add(T val){
        if(!setV.contains(val)){
            return setV.add(val);
        }

        return false;
    }

    public boolean remove(Object val){
        return setV.remove(val);
    }

    public boolean contains(Object val){
        return setV.contains(val);
    }

    public String toString(){
        return setV.toString();
    }
}
