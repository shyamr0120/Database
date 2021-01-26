/*
 * Read tmdb_5000_credits file, parse fields/columns and write normalized comma delimited files each entities of interest
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.io.FileWriter;
import java.io.PrintWriter;
 
public class Credits {
       ArrayList<String> credits = new ArrayList<String>();
       PrintWriter castWriter;
       PrintWriter crewWriter;
       String line = "";
       String x;
 
       public static void main(String[] args) throws IOException {
              new Credits().execute();
       }
 
       private void execute() throws IOException {
              String tmdb_5000_credits = "C:\\shyam\\MySQL\\tmdb\\tmdb_5000_credits.csv";
              line = "";
              Parser parser;
              String field = null;
              
              /*
               * Assign FileWriter for each of the parsed entity files 
               */
              try {
                     // cast table //
                     FileWriter fw1 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\cast.csv");
                     castWriter = new PrintWriter(fw1);

                     // crew table //
                     FileWriter fw2 = new FileWriter("C:\\shyam\\MySQL\\tmdb\\crew.csv");
                     crewWriter = new PrintWriter(fw2);
              } catch (Exception e) {
                     e.printStackTrace();
              }

              /*
              * parse tmdb_5000_credits.csv
              * Read each line from the file, call "parser", and write fields/columns as comma seperated output file
              */

              try (BufferedReader br = new BufferedReader(new FileReader(tmdb_5000_credits))) {
                     // skip the header line
                     line = br.readLine();
 
                     while ((line = br.readLine()) != null) {
                           parser = new Parser(line);
                           field = null;
 
                           while ((field = parser.getNextField()) != null) {
                                  // System.out.println(field);
                                  if (field == null || field.isEmpty()) {field = "NULL";}
                                  credits.add(field);
                           }
 
                           // parse cast json document
                           List<String> values = Parser.getValues(credits.get(2), new String[] { "id", "name", "gender", "cast_id", "character", });
                           // values.forEach(System.out::println);
                           for (String value : values) {
                                  x = value.replaceAll(",$", ",NULL");
                                  value = x;
                                  castWriter.println(credits.get(0) + "," + value);
                           }
                          
                           // parse crew json document
                           values = Parser.getValues(credits.get(3).replace("credit_id", "credit"), new String[] { "id", "name", "gender", "department", "job" });
                           // values.forEach(System.out::println);
                           for (String value : values) {
                                  crewWriter.println(credits.get(0) + "," + value);
                           }
 
                           credits.clear();
                     }
 
                     // close out FileWriter
                     castWriter.close();
                     crewWriter.close();
                     // close BufferedReader
                     br.close();
                     
                     System.out.println("File at " + tmdb_5000_credits + " parsed");
                                           
              } catch (Exception e) {
                    
              }
       }
}
