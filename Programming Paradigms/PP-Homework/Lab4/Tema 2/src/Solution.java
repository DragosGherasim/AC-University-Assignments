public class Solution {
    public static void main(String[] args){
        BankAccount cinemaBankAcc = new BankAccount(3000, "123456789", 2024, 999, "CinemaCapitol");
        BankAccount personalBankAcc = new BankAccount(100, "321654987", 2023, 888, "Dragos Gh");

        Cinema cinemaCap = new Cinema(new CardCashing(cinemaBankAcc));
        Vanzator vanzCinema = new Vanzator("Vasile");
        Cumparator cumpBilet = new Cumparator("Dragos", "Avatar 2", new CardPayment(personalBankAcc));

        Film film;
        if ((film = vanzCinema.gasireFilm(cinemaCap.getListaFilme(), cumpBilet.getNumeFilm())) != null){
            double pretFilm;

            if (cumpBilet.plataFilm(pretFilm = film.getPret())){
                vanzCinema.procesIncasare(pretFilm, cinemaCap.getMetodaIncasare());
                cinemaBankAcc.afisareBalanta();
                personalBankAcc.afisareBalanta();
            }
            else{
                System.out.println("Ne pare rau dar balanta dumneavoastra este insuficienta !");
            }
        }
        else{
            System.out.println("Filmul nu este pe lista noastra de filme disponibile momentan !");
        }
    }
}
