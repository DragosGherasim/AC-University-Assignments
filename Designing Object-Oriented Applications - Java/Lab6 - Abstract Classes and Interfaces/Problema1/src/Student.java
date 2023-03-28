public class Student implements Comparable<Student>{
    protected String name;
    protected int age;
    protected int grade;

    public Student(){
        this.name = "";
        this.age = 0;
        this.grade = 0;
    }

    public Student(String name, int age, int grade){
        this.name = name; // this = s => modifica instanta curenta error
        this.age = age;
        this.grade = grade;
    }

    public Student(Student s){
        this.name = s.name;
        this.age = s.age;
        this.grade = s.grade;
    }

    public String getName(){
        return this.name;
    }

    public int getAge(){
        return this.age;
    }

    public int getGrade(){
        return this.grade;
    }

    @Override
    public String toString() {
        return super.toString();
    }

    @Override
    public Student clone(){
        return new Student(this);
    }

    @Override
    public int compareTo(Student o){
        if (this.name.compareTo(o.name) == 0){
            if (this.age - o.age == 0){
                return this.grade - o.grade;
            }
            else{
                return this.age - o.age;
            }
        }
        else return this.name.compareTo(o.name);
    }
}
