package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Guestbook;


public class GuestbookDAO {

	private final String SQL_SELECTGUESTBOOKLIST = "select * from guestbook";
	
	public List selectGuestbookList() throws SQLException{
				
		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {

			String select = SQL_SELECTGUESTBOOKLIST;
			ps = con.prepareStatement(select);
			rs = ps.executeQuery();

			List<Guestbook> list = new ArrayList<Guestbook>();
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
			return list;
		} finally {
			close(con,ps,rs);	
		}
	}
	
	public void close(Connection con, PreparedStatement ps, ResultSet rs)  throws SQLException{
		if (con != null) con.close();
		if (ps != null) ps.close();
		if (rs != null) rs.close();	
	}
}
