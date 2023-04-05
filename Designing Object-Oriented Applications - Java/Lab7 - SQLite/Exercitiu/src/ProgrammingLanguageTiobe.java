public class ProgrammingLanguageTiobe implements Comparable<ProgrammingLanguageTiobe>{
    private final int may2019;
    private final int may2018;
    private final String change;
    private final String name;
    private final String rating;

    public ProgrammingLanguageTiobe(int m19, int m18, String ch, String nm, String rg){
        may2019 = m19;
        may2018 = m18;
        change = ch;
        name = nm;
        rating = rg;
    }

    public void Display(){
        System.out.println(may2019 + ", " + may2018 + ", " + change + ", " + name +
                ", " + rating);
    }

    public int getMay2019(){
        return may2019;
    }

    public int getMay2018(){
        return may2018;
    }

    public String getChange(){
        return change;
    }

    public String getName(){
        return name;
    }

    public String getRating(){
        return rating;
    }

    @Override
    public int compareTo(ProgrammingLanguageTiobe o) {
        Double ratingDouble = Double.parseDouble(rating.replace("%", ""));
        Double oRatingDouble = Double.parseDouble(o.getRating().replace("%", ""));

        return ratingDouble.compareTo(oRatingDouble);
    }
}
