import java.sql.*;
import java.text.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.io.*;
import java.util.*;

public class Load {
	static final String DB_URL = "jdbc:mysql://localhost:3306/?useSSL=false";
	static final String USER = "root";
	static final String PASS = "admin";

	public static void main(String[] args) {
		Connection conn = null;
		String csvFile;
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";

		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			Statement stmt = conn.createStatement();

			// Create database
			//String sql = "DROP DATABASE Final_Project";
			//stmt.executeUpdate(sql);

			//sql = "CREATE DATABASE Final_Project";
			//stmt.executeUpdate(sql);
			//System.out.println("Database created");
			// Use database
			String sql = "USE Final_Project";
			stmt.executeUpdate(sql);

			// movie table
            /*
			csvFile = "C:\\shyam\\MySQL\\tmdb\\movie.csv";
			System.out.println();
			System.out.println("Creating movies Table...");
			System.out.println();
			
			sql = "CREATE TABLE IF NOT EXISTS movies (" 
					+ "movie_id FLOAT NOT NULL," 
					+ "movie_title VARCHAR(100) NULL," 
					+ "movie_release_date VARCHAR(20) NULL," 
					+ "movie_language VARCHAR(10) NULL," 
					+ "movie_popularity FLOAT NULL," 
					+ "movie_revenue FLOAT NULL,"
					+ "movie_budget FLOAT NULL,"
					+ "movie_status VARCHAR(100) NULL," 
					+ "movie_tagline VARCHAR(1000) NULL,"
					+ "movie_vote_average FLOAT NULL,"
 					+ "movie_vote_count FLOAT NULL," 
					+ "movie_runtime FLOAT NULL," 
					+ "PRIMARY KEY (movie_id)," 
					+ "UNIQUE INDEX movie_id_UNIQUE (movie_id ASC) VISIBLE)";

			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO movies VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setFloat(1, Float.parseFloat(token[++i]));
				pstmt.setString(2, token[++i]);
				pstmt.setString(3, token[++i]);
				pstmt.setString(4, token[++i]);
				pstmt.setFloat(5, Float.parseFloat(token[++i]));
				pstmt.setFloat(6, Float.parseFloat(token[++i]));
				pstmt.setFloat(7, Float.parseFloat(token[++i]));
				pstmt.setString(8, token[++i]);
				pstmt.setString(9, token[++i]);
				pstmt.setFloat(10, Float.parseFloat(token[++i]));
				pstmt.setFloat(11, Float.parseFloat(token[++i]));
				pstmt.setFloat(12, Float.parseFloat(token[++i]));

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("Movies Table Created");
			System.out.println();
			
*/
			// keywords table
			System.out.println();
			System.out.println("Creating keywords Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\keywords.csv";
			sql = "CREATE TABLE IF NOT EXISTS keywords (movie_id INT NOT NULL, key_id INT NOT NULL, key_description VARCHAR(100) NULL,PRIMARY KEY (key_id, movie_id))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO keywords VALUES (?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setInt(2, Integer.parseInt(token[++i]));
				pstmt.setString(3, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("keywords Table Created");
			System.out.println();
/*
			
			// genres table
			System.out.println();
			System.out.println("Creating genres Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\genres.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS genres (movie_id INT NOT NULL,genres_id INT NOT NULL,genres_title VARCHAR(50) NULL,PRIMARY KEY (genres_id, movie_id))";

			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO genres VALUES (?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setInt(2, Integer.parseInt(token[++i]));
				pstmt.setString(3, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("genres Table Created");
			System.out.println();
			
			
			// cast table
			System.out.println();
			System.out.println("Creating cast Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\cast.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS cast (movie_id INT NOT NULL,cast_id INT NOT NULL,cast_name VARCHAR(100) NOT NULL,actor_gender INT NULL,actor_id INT NULL,cast_character VARCHAR(500) NOT NULL,PRIMARY KEY (cast_id, movie_id, cast_name))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO cast VALUES (?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setInt(2, Integer.parseInt(token[++i]));
				pstmt.setString(3, token[++i]);
				pstmt.setInt(4, Integer.parseInt(token[++i]));
				pstmt.setInt(5, Integer.parseInt(token[++i]));
				pstmt.setString(6, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("cast Table Created");
			System.out.println();


			// crew table
			System.out.println();
			System.out.println("Creating crew Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\crew.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS crew (movie_id INT NOT NULL,crew_id INT NOT NULL,crew_name VARCHAR(100) NOT NULL,crew_gender INT NOT NULL,department VARCHAR(20) NULL,crew_job VARCHAR(100) NOT NULL,PRIMARY KEY (crew_id, movie_id, crew_name, crew_job))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO crew VALUES (?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setInt(2, Integer.parseInt(token[++i]));
				pstmt.setString(3, token[++i]);
				pstmt.setInt(4, Integer.parseInt(token[++i]));
				pstmt.setString(5, token[++i]);
				pstmt.setString(6, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("crew Table Created");
			System.out.println();

			// production_country table
			System.out.println();
			System.out.println("Creating production_country Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\countries.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS production_country (movie_id INT NOT NULL,country_code VARCHAR(10) NOT NULL,country_name VARCHAR(50) NULL,PRIMARY KEY (country_code, movie_id))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO production_country VALUES (?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();
				
				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setString(2, token[++i]);
				pstmt.setString(3, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("production_country Table Created");
			System.out.println();


			// production_company table
			System.out.println();
			System.out.println("Creating production_country Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\production.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS production_company (movie_id INT NOT NULL,company_id INT NOT NULL,company_name VARCHAR(100) NULL,PRIMARY KEY (company_id, movie_id))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));

			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO production_company VALUES (?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setString(2, token[++i]);
				pstmt.setString(3, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("production_company Table Created");
			System.out.println();

			// spoken_languages table
			System.out.println();
			System.out.println("Creating spoken_languages Table...");
			System.out.println();
			csvFile = "C:\\shyam\\MySQL\\tmdb\\production.csv";
			
			sql = "CREATE TABLE IF NOT EXISTS spoken_languages (movie_id INT NOT NULL,language_id VARCHAR(10) NOT NULL,language_name VARCHAR(50) NULL,PRIMARY KEY (language_id, movie_id))";
			
			stmt.executeUpdate(sql);

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				int i = -1;
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				sql = "INSERT INTO spoken_languages VALUES (?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				pstmt.clearParameters();

				pstmt.setInt(1, Integer.parseInt(token[++i]));
				pstmt.setString(2, token[++i]);
				pstmt.setString(3, token[++i]);

				try {pstmt.executeUpdate();} catch (Exception e) {}
				pstmt.close();
			}

			System.out.println("spoken_languages Table Created");
			System.out.println();
*/
	
		} catch (Exception e) {
			System.out.println(line);
			System.out.println("SQL Exception.");
			e.printStackTrace();
		}
	}
}