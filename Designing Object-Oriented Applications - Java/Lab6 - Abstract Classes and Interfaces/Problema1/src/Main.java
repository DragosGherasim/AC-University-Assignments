public class Main {
    public static void main(String[] args){
        StudentClass cls = new StudentClass(5);
        Consultant cA = new ConsultantOrderByAge();
        Consultant cN = new ConsultantOrderByName();
        Consultant cG = new ConsultantOrderByGrade();
        Consultant cP = new ConsultantPrint();

        cls.Add(new Student("Dragos", 22, 4));
        cls.Add(new Student("Rares", 21, 9));
        cls.Add(new Student("Dani", 21, 3));
        cls.Add(new Student("Stefan", 20, 9));
        cls.Add(new Student("Mihai", 20, 10));

        cls.Add(cP);
        cls.ExecuteOrder();

        System.out.println();

        cls.Add(cN);
        cls.ExecuteOrder();

        cls.Add(cP);
        cls.ExecuteOrder();

        System.out.println();

        cls.Add(cA);
        cls.ExecuteOrder();

        cls.Add(cP);
        cls.ExecuteOrder();

        System.out.println();

        cls.Add(cG);
        cls.ExecuteOrder();

        cls.Add(cP);
        cls.ExecuteOrder();
    }
}
