package CRUD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DB_Connection;

public class GetMovies {
	public static String listMovies() throws SQLException {
		DB_Connection DBConnection = new DB_Connection();
		Connection connection = DBConnection.get_connection();	
		
		PreparedStatement stmt = connection.prepareStatement("SELECT * FROM movielibrary");
		ResultSet rs = stmt.executeQuery();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("[");
		while(rs.next()) {
			int ID = rs.getInt("ID");
			String movie_title = rs.getString("movie_title");
			float price = rs.getFloat("price");
			if (ID != 1) stringBuilder.append(",");
			stringBuilder.append("{\"ID\":" + ID + ",");
			stringBuilder.append("\"Title\":\"" + movie_title + "\",");
			stringBuilder.append("\"Price\":" + price + "}");
		}
		stringBuilder.append("]");
		return stringBuilder.toString();
		}
}
