import java.util.Vector;
public class SetAsVector1<T> extends Vector<T> {
    @Override
    public boolean add(T val){
        if(!super.contains(val)){
            return super.add(val);
        }

        return false;
    }

    @Override
    public boolean remove(Object val){
        return super.remove(val);
    }

    @Override
    public boolean contains(Object val){
        return super.contains(val);
    }

    @Override
    public String toString(){
        return super.toString();
    }
}
