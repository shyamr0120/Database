/*
 * Parse a given string object into comma delimited fields. In doing so, treat the json document array as a single field
 * by excluding commas within json document array.
 * Also, parse the json document array as name-value pair, and return name-value pair as comma delimited field 
 */

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
 
public class Parser {
       private String input;

       public Parser(String input) {
              this.input = input;
       }
 
       /*
        * return each field as a comma delimited
        */
       public String getNextField() {
              if (input.length() == 0) {
                     return null;
              }
 
              String field = null;
              input = input.trim();
              char firstChar = input.charAt(0);
 
              if (firstChar == '"') {
                     return getQuotedString();
              }
 
              int inx = input.indexOf(',');
              if (inx >= 0) {
                     field = input.substring(0, inx);
                     input = input.substring(inx + 1);
              } else {
                     field = input;
                     input = "";
              }
 
              return field;
       }
 
       /*
        * treat the json document array as a single filed by excluding commas
        */
       private String getQuotedString() {
              int inx = 1;
              StringBuffer sb = new StringBuffer("\"");
 
              while (inx < input.length()) {
                     // If the current char is double-quote and the next char is not double-queue then it is end-of-field...
                     if (input.charAt(inx) == '"') {
                           if (inx+1 >= input.length() || input.charAt(inx+1) != '"')  {
                                  sb.append('"');
                                  break;
                           }
                     }
 
                     if (input.charAt(inx) == '"' && input.charAt(inx + 1) == '"') {
                           sb.append('"').append('"');
                           inx += 2;
                     } else {
                           sb.append(input.charAt(inx));
                           inx++;
                     }
              }
 
              String field = sb.toString();
              input = input.substring(field.length());
 
              // Skip until field separator ','
              inx = input.indexOf(',');
              if (inx >= 0) {
                     input = input.substring(inx + 1).trim();
              }
 
              return field;
       }
 
       /*
        * Parse the json document array and return each array as a comma delimited value
        */
       public static List<String> getValues(String input, String[] keys) throws IOException {
              List<String> objs = new ArrayList<String>();
 
              int begin;
              while ((begin = input.indexOf('{')) > 0) {
                     int end = input.indexOf('}');
                     if (end < 0) {
                           throw new IOException("Invalid input");
                     }
 
                     String obj = input.substring(begin, end + 1);
                     input = input.substring(end + 1);
                     objs.add(obj);
              }
 
              List<String> values = new ArrayList<String>();
              for (String obj : objs) {
                     values.add(extractValues(obj, keys));
              }
 
              return values;
       }
 
       /*
        * Extract the value for a given key from the json document element 
        */
       private static String extractValues(String obj, String[] keys) {
              StringBuffer sb = new StringBuffer();
 
              for (String key : keys) {
                     int inx = obj.indexOf(key);
                     if (inx < 0)
                           continue;
 
                     String s = obj.substring(inx + key.length());
                     inx = s.indexOf(',');
                     if (inx < 0)
                           inx = s.indexOf('}');
                     if (inx < 0)
                           continue;
 
                     s = s.substring(0, inx);
                     s = s.replace(":", "");
                     s = s.replace("\"", "");
                     s = s.trim();
 
                     sb = sb.length() > 0 ? sb.append(',').append(s) : sb.append(s);
              }
 
              return sb.toString();
       }
}