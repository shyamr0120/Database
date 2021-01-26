import java.io.IOException;

import java.nio.file.Files;

import java.nio.file.Paths;

 

public class TestParser {

      

       public static void main(String[] args) throws IOException {

              new TestParser().execute();

       }

 

       private void execute() throws IOException {

              //byte[] bytes = Files.readAllBytes(Paths.get("C:", "oncall", "shyam", "test.csv"));
           byte[] bytes = Files.readAllBytes(Paths.get("C:", "shyam", "MySQL", "tmdb", "tmdb_5000_credits.csv"));

              Parser parser = new Parser(new String(bytes));

              String field = null;

             

              while( (field = parser.getNextField()) != null) {

                     System.out.println(field);

              }

       }

}