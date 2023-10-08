import java.util.ArrayList;

public class MovieFinderByName implements IMovieFinder{
    @Override
    public Film findMovie(ArrayList<Film> listaFilme, String numeFilm) {
        for(Film film: listaFilme){
            if (film.getNume() == numeFilm){
                return film;
            }
        }

        return null;
    }
}
