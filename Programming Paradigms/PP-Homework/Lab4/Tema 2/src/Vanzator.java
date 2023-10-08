import java.util.ArrayList;

public class Vanzator {
    private String _nume;
    private final IMovieFinder _movieFinder; // dependency inversion(dependency injection)

    Vanzator(String nume){
        _nume = nume;

        _movieFinder = new MovieFinderByName();
    }

    public Film gasireFilm(ArrayList<Film> listaFilme, String numeFilm){
        return _movieFinder.findMovie(listaFilme, numeFilm);
    }

    public void procesIncasare(double pretFilm, CashingMethod metodaIncasare){
        metodaIncasare.cashing(pretFilm);
    }
}
