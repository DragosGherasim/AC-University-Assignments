import java.util.Arrays;
import java.util.Comparator;

public class ConsultantOrderByAge implements Consultant{

    @Override
    public void ExecuteOrder(Student[] v) {
        Arrays.sort(v, Comparator.comparingInt((Student s) -> s.age));
    }
}
