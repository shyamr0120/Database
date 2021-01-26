import java.sql.*;
import java.util.*;
import java.io.*;

public class Engine {
	static final String DB_URL = "jdbc:mysql://localhost:3306/?useSSL=false";
	static final String USER = "root";
	static final String PASS = "admin";

	public static void main(String[] args) 
	{
		Connection conn = null;
		String csvFile;
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		String input = "Harry Potter and the Chamber of Secrets";
		input = input.replaceAll(" ", "");
		float movie_id = 0;
		int movie_loc = 0;
		int ccc = 0;
		ArrayList<String> genre = new ArrayList<String>();
		ArrayList<String> key = new ArrayList<String>();
		ArrayList<String> crew = new ArrayList<String>();
		ArrayList<String> cast = new ArrayList<String>();
		ArrayList<String> company = new ArrayList<String>();
		ArrayList<String> country = new ArrayList<String>();

		try
		{
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			Statement stmt = conn.createStatement();
			String sql = "USE Final_Project";
			stmt.executeUpdate(sql);
			
			sql="SELECT count(*) FROM Movies";
			stmt.executeQuery(sql);
			
			ResultSet myRS = stmt.executeQuery(sql);
			myRS.next();
			int num = Integer.parseInt(myRS.getString(1));
			
			float movies[] = new float[num];
			int sim[] = new int[num];
			
			sql="SELECT * FROM Movies order by movie_id";
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			int count = 0;
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				String temp2 = myRS.getString("movie_title");
				temp2 = temp2.replaceAll(" ", "");
				String temp3 = "";
				movies[count] = Float.parseFloat(temp);
				for(int i = 0; i<temp2.length(); i++)
				{
					char c = temp2.charAt(i);
					temp3 = temp3 + c;
					if(temp3.equalsIgnoreCase(input))
					{
						//System.out.println(temp3);
						movie_id = Float.parseFloat(temp);
						movie_loc = count;
						break;
					}
				}
				count++;
			}
			
			//System.out.println(movie_id);
			
			if(movie_id == 0)
			{
				System.out.println(input+" not found in database.");
				System.exit(1);
			}
			
			
			count = 0;
			System.out.println("Searching Genres...");
			sql="SELECT * FROM Genres where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("genres_id");
				if(temp2 == movie_id)
				{
					genre.add(temp3);
					ccc++;
				}
			}
			
			
			
			for(int i = 0; i<genre.size(); i++)
			{
				String cgenre = genre.get(i);
				//System.out.println(cgenre);
				sql="SELECT * FROM Genres where genres_id = "+Float.parseFloat(cgenre);
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("genres_id");
					if(temp2.equals(cgenre))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4 = temp4 + 10;
								sim[j] = temp4;
							}
						}
					}
				}
			}
			
			count = 0;
			System.out.println("Searching Keywords...");
			sql="SELECT * FROM Keywords where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("key_id");
				if(temp2 == movie_id)
				{
					key.add(temp3);
					ccc++;
				}
			}
			
			
			
			for(int i = 0; i<key.size(); i++)
			{
				String ckey = key.get(i);
				//System.out.println(cgenre);
				sql="SELECT * FROM Keywords where key_id = "+Float.parseFloat(ckey);
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("key_id");
					if(temp2.equals(ckey))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4 = temp4 + 10;
								sim[j] = temp4;
							}
						}
					}
				}
			}
			
			count = 0;
			System.out.println("Searching Cast...");
			sql="SELECT * FROM Cast where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("cast_id");
				if(temp2 == movie_id)
				{
					cast.add(temp3);
					ccc++;
				}
			}
			
			
			
			for(int i = 0; i<cast.size(); i++)
			{
				String ccast = cast.get(i);
				//System.out.println(cgenre);
				sql="SELECT * FROM Cast where cast_id = "+Float.parseFloat(ccast);
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("cast_id");
					if(temp2.equals(ccast))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4 = temp4 + 1;
								sim[j] = temp4;
							}
						}
					}
				}
			}
			
			count = 0;
			System.out.println("Searching Crew...");
			sql="SELECT * FROM Crew where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("crew_id");
				if(temp2 == movie_id)
				{
					crew.add(temp3);
					ccc++;					
				}
			}
			
			
			for(int i = 0; i<crew.size(); i++)
			{
				String ccrew = crew.get(i);
				//System.out.println(ccrew);
				sql="SELECT * FROM Crew where crew_id = "+Float.parseFloat(ccrew);
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("crew_id");
					if(temp2.equals(ccrew))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4 = temp4 + 1;
								sim[j] = temp4;
							}
						}
					}
				}
			}
			
			count = 0;
			System.out.println("Searching Companies...");
			sql="SELECT * FROM Production_Company where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("company_id");
				if(temp2 == movie_id)
				{
					company.add(temp3);
					ccc++;
				}
			}
			
			
			
			for(int i = 0; i<company.size(); i++)
			{
				String ccompany = company.get(i);
				//System.out.println(ccompany);
				sql="SELECT * FROM Production_Company where company_id = "+Float.parseFloat(ccompany);
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("company_id");
					if(temp2.equals(ccompany))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4++;
								sim[j] = temp4;
							}
						}
					}
				}
	
			}
			
			count = 0;
			System.out.println("Searching Countries...");
			sql="SELECT * FROM Production_Country where movie_id = "+movie_id;
			stmt.executeQuery(sql);
			myRS = stmt.executeQuery(sql);
			
			while (myRS.next())
			{
				String temp = myRS.getString("movie_id");
				float temp2 = Float.parseFloat(temp);
				String temp3 = myRS.getString("country_code");
				if(temp2 == movie_id)
				{
					country.add(temp3);
					ccc++;
				}
			}
			
			
			for(int i = 0; i<country.size(); i++)
			{
				String ccountry = country.get(i);
				//System.out.println(ccountry);
				sql="SELECT * FROM Production_Country";
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("country_code");
					if(temp2.equals(ccountry))
					{
						for(int j = 0; j<sim.length; j++)
						{
							float temp3 = movies[j];
							if(temp3 == temp)
							{
								int temp4 = sim[j];
								temp4++;
								sim[j] = temp4;
							}
						}
					}
				}
			}
			//System.out.println(ccc);
			for (int i = 0; i < sim.length; i++)
			{
				for(int j = 1; j < sim.length-i-1; j++)
				{
					if(sim[j-1]<sim[j])
					{
						int temp = sim[j-1];
						float temp2 = movies[j-1];
						sim[j-1] = sim[j];
						movies[j-1] = movies[j];
	                    sim[j] = temp;
	                    movies[j] = temp2;
					}
				}
			}
			
			count = 0;
			String pop[] = new String[15];
			float imdb[] = new float[15];
			float vote[] = new float[15];
			float score[] = new float[15];
			
			for(int i = 0; i<movies.length; i++)
			{
				float check = movies[i];
				if(count == 16)
				{
					break;
				}
				sql="SELECT * FROM Movies";
				stmt.executeQuery(sql);
				myRS = stmt.executeQuery(sql);
				while (myRS.next())
				{
					float temp = Float.parseFloat(myRS.getString("movie_id"));
					String temp2 = myRS.getString("movie_title");
					float temp3 = Float.parseFloat(myRS.getString("movie_vote_average"));
					float temp4 = Float.parseFloat(myRS.getString("movie_vote_count"));
					if(temp == check)
					{
						//System.out.println(temp2+"			"+sim[i]);
						count++;
						if(i>0)
						{
							pop[i-1] = temp2;
							imdb[i-1] = temp3;
							vote[i-1] = temp4;
						}
					}
				}
			}
			count = 0;
			
			float max = vote[0];
			
			for (int i = 1; i < vote.length; i++)
			{
				if(vote[i]>max)
				{
					max = vote[i];
				}
			}
			//System.out.println(max);
			
			for(int i = 0; i<score.length; i++)
			{
				score[i] = (imdb[i])*(imdb[i])+(vote[i]/max);
			}
			
			for (int i = 0; i < score.length; i++)
			{
				for(int j = 1; j < score.length-i-1; j++)
				{
					if(score[j-1]<score[j])
					{
						float temp = score[j-1];
						String temp2 = pop[j-1];
						score[j-1] = score[j];
						pop[j-1] = pop[j];
	                    score[j] = temp;
	                    pop[j] = temp2;
					}
				}
			}
			
			for (int i = 0; i < 5; i++)
			{
				System.out.println(pop[i]+"			"+score[i]);
			}
			
		} 
		catch (SQLException e)
		{
			System.out.println(line);
			System.out.println("SQL Exception.");
			e.printStackTrace();
		}
	}
}