package CRUD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import common.DB_Connection;

public class AddMovie {
	public static void insertMovie(String title, float price) throws SQLException {
		DB_Connection DBConnection = new DB_Connection();
		Connection connection = DBConnection.get_connection();		
		String query = "INSERT INTO movielibrary(movie_title, price) VALUES (?, ?);";
		PreparedStatement ps = connection.prepareStatement(query);
		ps.setString(1, title);
		ps.setFloat(2, price);
		ps.executeUpdate();

	}
}
