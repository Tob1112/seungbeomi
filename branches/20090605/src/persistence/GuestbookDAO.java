package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Guestbook;

public class GuestbookDAO {

	private final String SQL_SELECTGUESTBOOKLIST = "select * from guestbook";
	
	public List selectGuestbookList() throws SQLException{
				
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException se) {
			se.printStackTrace();
		}
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String url = "jdbc:postgresql://localhost:5432/guestbook";
		String id = "pgsql";
		String pw = "pgsql";

		List<Guestbook> list = new ArrayList<Guestbook>();
		try {
			con = DriverManager.getConnection(url, id, pw);

			String select = SQL_SELECTGUESTBOOKLIST;
			ps = con.prepareStatement(select);
			rs = ps.executeQuery();

			while (rs.next()) {
				Guestbook guestbook = new Guestbook();
				guestbook.setNo(rs.getInt("no"));
				guestbook.setUserId(rs.getString("user_id"));
				guestbook.setTitle(rs.getString("title"));
				guestbook.setPostdate(rs.getTimestamp("postdate"));
				guestbook.setCategory(rs.getString("category"));
				guestbook.setComment(rs.getString("comment"));
				System.out.println(">>> " + guestbook);
				list.add(guestbook);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);			
		}
		for (Guestbook guestbook : list) {
			System.out.println("- " + guestbook );
		}
		return list;
	}
	
	public void close(Connection con, PreparedStatement ps, ResultSet rs)  throws SQLException{
		if (con != null) con.close();
		if (ps != null) ps.close();
		if (rs != null) rs.close();	
	}
}
