import org.graalvm.polyglot.*;
class Polyglot {
    private static int[] PyInputNum(){
        Context polyglot = Context.newBuilder().allowAllAccess(true).build();

        Value result = polyglot.eval("python", "[int(input(\"Nr : \")) for indx in range(1, 3)]");

        int[] arr = new int[2];
        for(int i = 0; i < arr.length; ++i){
            arr[i] = result.getArrayElement(i).asInt();
        }

        polyglot.close();

        return arr;
    }

    private static double RBinCumulProb(int n_success, int n_trials, double probability){
        Context polyglot = Context.newBuilder().allowAllAccess(true).build();
        Value result = polyglot.eval("R", "dbinom(" + n_success + "," + n_trials + ", " + probability + ")");

        double probResulted = result.asDouble();

        polyglot.close();

        return probResulted;
    }

    public static void main(String[] args){
        int[] arr = PyInputNum();

        int num_trials = arr[1], num_success = arr[0];
        double probability = 0.5;

        System.out.printf("\nBinomial Probability : %.3f\n",RBinCumulProb(num_success, num_trials, probability));

    }
}
