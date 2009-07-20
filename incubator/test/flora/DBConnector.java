package flora;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	public static Connection getConnection() throws SQLException {
		 Connection con = null;

		String driver = "com.mysql.jdbc.Driver";
        String URL = "jdbc:mysql://192.168.0.5:3306/test?useUnicode=true&amp;characterEncoding=UTF-8";
        String USER = "root";
        String PASSWORD = "mysql";

        try {
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
        return con;
    }
}
