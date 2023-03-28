import java.util.Arrays;

public class ConsultantOrderByGrade implements Consultant{
    @Override
    public void ExecuteOrder(Student[] v) {
        Arrays.sort(v, (Student s1, Student s2) -> s1.grade - s2.grade);
    }
}
