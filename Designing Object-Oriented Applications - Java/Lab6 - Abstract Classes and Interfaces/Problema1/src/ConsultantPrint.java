public class ConsultantPrint implements Consultant{
    @Override
    public void ExecuteOrder(Student[] v) {
        for (Student s : v){
            System.out.println(s.name + " " + s.age + " " + s.grade);
        }
    }
}
