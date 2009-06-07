package test.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Guestbook;

import persistence.DBConnector;
import junit.framework.TestCase;

public class GuestbookDAOTest02 extends TestCase {
	
	private static final String SQL_SELECTGUESTBOOKLIST = "select * from guestbook";
	private static final String SQL_INSERTGUESTBOOK = "insert into guestbook values (nextval('guestbook_no_seq'), ?, ?, ?, ?, ?)";
	private static final String SQL_SELECTGUESTBOOK = "select * from guestbook where no = ?";
	private static final String SQL_UPDATEGUESTBOOK = "update guestbook set user_id = ?, title = ?, category = ?, postdate = ?, comment = ? where no = ?";
	private static final String SQL_DELETEGUESTBOOK = "delete from guestbook where no = ?";
	
	@Override
	protected void setUp() throws Exception {
		
	}
	
	@Override
	protected void tearDown() throws Exception {
		// TODO Auto-generated method stub
		super.tearDown();
	}
	
	public void testSelectGuestbookList() throws SQLException{
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
			assertEquals(2, list.size());
						
		} finally {
			close(con,ps,rs);	
		}
	}
	
	public void close(Connection con, PreparedStatement ps, ResultSet rs)  throws SQLException{
		if (con != null) con.close();
		if (ps != null) ps.close();
		if (rs != null) rs.close();	
	}
	
	//assertEquals(1, userDAO.insert(user));
	
	private Guestbook populateGuestbook() {
		Guestbook guestbook = new Guestbook();
		guestbook.setNo(1);
		guestbook.setUserId("userId");
		guestbook.setTitle("title");
		guestbook.setPostdate(Timestamp.valueOf("2009-06-07"));
		guestbook.setCategory("category");
		guestbook.setComment("comment");
		return guestbook;		
	}
	
}
