
/*
 * Read tmdb_5000_movies file, parse fields/columns and write normalized comma delimited files each entities of interest
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.io.FileWriter;
import java.io.PrintWriter;
 
public class Movies {
       ArrayList<String> movies = new ArrayList<String>();
       PrintWriter movieWriter;
       PrintWriter genresWriter;
       PrintWriter keywordsWriter;
       PrintWriter productionWriter;
       PrintWriter countryWriter;
       PrintWriter spokenLanguagesWriter;
       String line = "";
 
       public static void main(String[] args) throws IOException {
              new Movies().execute();
       }
 
       private void execute() throws IOException {
              String tmdb_5000_movies = "C:\\shyam\\MySQL\\tmdb\\tmdb_5000_movies.csv";
              line = "";
              Parser parser;
              String field = null;

              /*
               * Assign FileWriter for each of the parsed entity files 
               */
              try {
                     // movie table //
                     FileWriter fw1 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\movie.csv");
                     movieWriter = new PrintWriter(fw1);

                     // genres table //
                     FileWriter fw2 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\genres.csv");
                     genresWriter = new PrintWriter(fw2);

                     // keywords table //
                     FileWriter fw3 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\keywords.csv");
                     keywordsWriter = new PrintWriter(fw3);

                     // production_companies table //
                     FileWriter fw4 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\production.csv");
                     productionWriter = new PrintWriter(fw4);

                     // countries_companies table //
                     FileWriter fw5 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\countries.csv");
                     countryWriter = new PrintWriter(fw5);
                     
                     // other_languages table //
                     FileWriter fw6 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\spoken_languages.csv");
                     spokenLanguagesWriter = new PrintWriter(fw6);
              } catch (Exception e) {
              }

              /*
              * parse tmdb_5000_movies.csv
              * Read each line from the file, call "parser", and write fields/columns as comma seperated output file 
              */

              try (BufferedReader br = new BufferedReader(new FileReader(tmdb_5000_movies))) {
                     // skip the header line
                     line = br.readLine();

                     while ((line = br.readLine()) != null) {
                           parser = new Parser(line);
                           field = null;
 
                           while ((field = parser.getNextField()) != null) {
                                  // System.out.println(field);
                                  if (field == null || field.isEmpty()) {field = "NULL";}
                                         movies.add(field);
                           }
 
                           // parse genres json document
                           List<String> values = Parser.getValues(movies.get(1), new String[] { "id", "name" });
                           // values.forEach(System.out::println);
                           for (String value : values) {
                                  genresWriter.println(movies.get(3) + "," + value);
                           }
 
                           // parse keywords json document
                           values = Parser.getValues(movies.get(4), new String[] { "id", "name" });
                           for (String value : values) {
                                  keywordsWriter.println(movies.get(3) + "," + value);
                           }
 
                           // parse production_companies json document
                           values = Parser.getValues(movies.get(9), new String[] { "id", "name" });
                           for (String value : values) {
                                  productionWriter.println(movies.get(3) + "," + value);
                           }
 
                           // parse countries json document
                           values = Parser.getValues(movies.get(10), new String[] { "iso_3166_1", "name" });
                           for (String value : values) {
                                  countryWriter.println(movies.get(3) + "," + value);
                           }
                           
                           // other languages json document
                           values = Parser.getValues(movies.get(14), new String[] { "iso_639_1", "name" });
                           for (String value : values) {
                                  spokenLanguagesWriter.println(movies.get(3) + "," + value);
                           }
 
                           writer();
                           movies.clear();
                     }
 
                     // close out FileWriter
                     genresWriter.close();
                     keywordsWriter.close();
                     productionWriter.close();
                     countryWriter.close();
                     spokenLanguagesWriter.close();
                     movieWriter.close();
                     // close BufferedReader
                     br.close();

                     System.out.println("File at " + tmdb_5000_movies + " parsed");
              } catch (Exception e) {
                     e.printStackTrace();
              }
       }
 
       /*
        * Write "movie" attributes as comma sepearted file
        */
       private void writer() throws Exception {
    	   
              try {
            	  movieWriter.println(	movies.get(3).replaceAll(",", "") + "," +
                               			movies.get(6).replaceAll(",", "") + "," +  // movie name
                               			movies.get(11).replaceAll(",", "") + "," +
                               			movies.get(5).replaceAll(",", "") + ","   +
                               			movies.get(8).replaceAll(",", "") + "," +
                               			movies.get(12).replaceAll(",", "") + "," +
                               			movies.get(0).replaceAll(",", "") + "," +
                               			movies.get(15).replaceAll(",", "") + ","+
                               			movies.get(16).replaceAll(",","") + ","+   //tagline
                               			movies.get(18).replaceAll(",", "") + "," +
                               			movies.get(19).replaceAll(",", "") + "," +
                               			movies.get(13).replaceAll("NULL", "0"));
       } catch (Exception e) {System.out.println(line);}
       }
 }
