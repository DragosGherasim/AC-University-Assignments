import java.util.Arrays;
import java.util.Comparator;

public class ConsultantOrderByName implements Consultant{

    @Override
    public void ExecuteOrder(Student[] v) {
        Arrays.sort(v, Comparator.comparing((Student s) -> s.name));
    }
}
