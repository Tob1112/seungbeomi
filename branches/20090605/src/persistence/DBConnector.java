package persistence;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnector {
	public static Connection getConnection() {
        Connection con = null;
        /*
        String driver = "org.postgresql.Driver";
        String url = "jdbc:postgresql://localhost:5432/guestbook";
		String id = "pgsql";
		String pw = "pgsql";
         */
		
		String driver = "org.hsqldb.jdbcDriver";
		String url = "jdbc:hsqldb:hsql://localhost:9002";
		//String url = "jdbc:hsqldb:guestbookdb";
		String id = "sa";
		String pw = "";
        
		try {
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url,id,pw);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}

