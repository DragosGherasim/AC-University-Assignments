public class Film {
    private String _nume;
    private double _pret;

    Film(String nume, double pret){
        _nume = nume;
        _pret = pret;
    }

    public double getPret(){
        return _pret;
    }

    public String getNume(){
        return _nume;
    }
}
