public class Stiva {
    private int[] arr;
    private int top;

    Stiva(){
        arr = new int [100];
        top = 0;
    }

    Stiva(int dim){
        arr = new int [dim];
        top = 0;
    }

    public void Push(int val){
        if (arr.length > top) {
            arr[top++] = val;
        }
        else {
            System.out.println("Stiva este full");
        }
    }

    public int Pop(){
        if (top != 0){
            return arr[--top];
        }
        else{
            System.out.println("Stiva este goala");
            return 0;
        }
    }

     public boolean isEmpty(){
        return top == 0;
     }
}
