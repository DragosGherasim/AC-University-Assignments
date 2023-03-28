public class StudentClass {
    private Student[] v;
    private int n;
    private final int N = 10;

    private Consultant c;

    public StudentClass(){
        this.v = null;
        this.n = 0;
    }

    public StudentClass(int size){
        this.n = 0;
        this.v = new Student[size];
    }

    public void Add(Student s){
        if (n < N){
            v[n++] = s.clone();
        }
        else{
            System.out.println("Clasa este plina !");
        }
    }

    public void Add(Consultant c){
        this.c = c;
    }

    public void ExecuteOrder(){
        c.ExecuteOrder(v);
    }
}
