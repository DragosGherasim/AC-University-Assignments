import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class DataBase {
    private Connection conn;
    private Statement stmt;
    DataBase(){
        try{
            String dbname = "org.sqlite.JDBC";
            Class.forName(dbname);

            String dbPath = "jdbc:sqlite:tiobe1.db";
            conn = DriverManager.getConnection(dbPath);
            stmt = conn.createStatement();

            String sql = "CREATE TABLE IF NOT EXISTS tiobe" +
                    "(ID INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "May2019 INT NOT NULL," +
                    "May2018 INT NOT NULL," +
                    "Change TEXT NOT NULL," +
                    "'Programming Language' TEXT NOT NULL," +
                    "Ratings TEXT NOT NULL)";
            stmt.execute(sql);
            stmt.close();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Table created successfully");
    }

    public void Insert(ProgrammingLanguageTiobe prgLan) {
        try{
            conn.setAutoCommit(false);
            String sql = "INSERT OR IGNORE INTO tiobe (May2019, May2018, Change, 'Programming Language', Ratings) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, prgLan.getMay2019());
            pstmt.setInt(2, prgLan.getMay2018());
            pstmt.setString(3, prgLan.getChange());
            pstmt.setString(4, prgLan.getName());
            pstmt.setString(5, prgLan.getRating());

            pstmt.executeUpdate();
            pstmt.close();
            conn.commit();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Programming Language Tiobe created successfully");
    }

    public void SelectAll(){
        try {
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tiobe");

            while (rs.next()){
                System.out.println(rs.getInt("May2019") + ", " + rs.getInt("May2018") + ", " +
                        rs.getString("Change") + ", " + rs.getString("Programming Language") +
                        ", " + rs.getString("Ratings"));
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("SelectALL operation successfully");
    }

    public void SelectPos(){
        try {
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT Change, \"Programming Language\" FROM tiobe");

            while (rs.next()){
                String changeStr = rs.getString("Change");
                String changeStrNew = changeStr.replace("%", "");

                if (Double.parseDouble(changeStrNew) > 0){
                    System.out.println(changeStr + ", " + rs.getString("Programming Language"));
                }
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("SelectPos operation successfully");
    }

    public ArrayList<ProgrammingLanguageTiobe> SelectInJTable(){
        ArrayList<ProgrammingLanguageTiobe> list = new ArrayList<>();

        try {
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tiobe");

            while (rs.next()){
                int may2019 = rs.getInt("May2019");
                int may2018 = rs.getInt("May2018");
                String change = rs.getString("Change");
                String prgLangName = rs.getString("Programming Language");
                String rating = rs.getString("Ratings");
                list.add(new ProgrammingLanguageTiobe(may2019, may2018, change, prgLangName, rating));
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        System.out.println("SelectInJTable operation successfully");

        return list;
    }

    public void UpdateByRating(String nume, String rating){
        try {
            conn.setAutoCommit(false);
            String sql = "UPDATE tiobe SET Ratings = ? WHERE \"Programming Language\" = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);


            pstmt.setString(1, rating);
            pstmt.setString(2, nume);
            pstmt.executeUpdate();

            pstmt.close();
            conn.commit();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("UpdateByRatingsDesc operation successfully");
    }
    public void UpdateByRatingDesc(){
        List<ProgrammingLanguageTiobe> list = new ArrayList<>();

        try {
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tiobe");
            while (rs.next()){
                list.add(new ProgrammingLanguageTiobe(rs.getInt("May2019"), rs.getInt("May2018"),
                        rs.getString("Change"), rs.getString("Programming Language"),
                        rs.getString("Ratings")));
            }
            rs.close();
            stmt.close();

            list.sort(Comparator.reverseOrder());

            String sql = "UPDATE tiobe SET May2019 = ?, May2018 = ?, Change = ?, \"Programming Language\" = ?, Ratings = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            int id = 1;
            for (ProgrammingLanguageTiobe prgLan : list){
                pstmt.setInt(1, prgLan.getMay2019());
                pstmt.setInt(2, prgLan.getMay2018());
                pstmt.setString(3, prgLan.getChange());
                pstmt.setString(4, prgLan.getName());
                pstmt.setString(5, prgLan.getRating());
                pstmt.setInt(6, id++);
                pstmt.executeUpdate();
            }
            pstmt.close();
            conn.commit();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("UpdateByRatingsDesc operation successfully");
    }

    public void UpdateFromJTable(ProgrammingLanguageTiobe prgLan, int row){
        try {
            conn.setAutoCommit(false);

            String sql = "UPDATE tiobe SET May2019 = ?, May2018 = ?, Change = ?, \"Programming Language\" = ?, Ratings = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, prgLan.getMay2019());
            pstmt.setInt(2, prgLan.getMay2018());
            pstmt.setString(3, prgLan.getChange());
            pstmt.setString(4, prgLan.getName());
            pstmt.setString(5, prgLan.getRating());
            pstmt.setInt(6, row);
            pstmt.executeUpdate();

            pstmt.close();
            conn.commit();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("UpdateFromJTable operation successfully");
    }

    public void DeleteByName(String name){
        try{
            conn.setAutoCommit(false);
            String sql = "DELETE FROM tiobe WHERE \"Programming Language\" = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, name);
            pstmt.executeUpdate();

            pstmt.close();
            conn.commit();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("DeleteByName operation successfully");
    }

    public void DropTable(){
        try{
            conn.setAutoCommit(false);
            stmt = conn.createStatement();

            String sql = "DROP TABLE tiobe";
            stmt.executeUpdate(sql);
            stmt.close();
            conn.commit();
            conn.close();
        }
        catch (Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Table successfully deleted");
    }
}
