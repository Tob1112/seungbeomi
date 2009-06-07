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

public class GuestbookDAOTest extends TestCase {

	private static final String SQL_SELECTGUESTBOOKLIST = "select * from guestbook";
	private static final String SQL_INSERTGUESTBOOK = "insert into guestbook values (nextval('guestbook_no_seq'), ?, ?, ?, ?, ?)";
	private static final String SQL_SELECTGUESTBOOK = "select * from guestbook where no = ?";
	private static final String SQL_UPDATEGUESTBOOK = "update guestbook set user_id = ?, title = ?, category = ?, postdate = ?, comment = ? where no = ?";
	private static final String SQL_DELETEGUESTBOOK = "delete from guestbook where no = ?";
	
	protected void setUp() throws Exception {
		super.setUp();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public List<Guestbook> testSelectGuestbookList() {

		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Guestbook> list = new ArrayList<Guestbook>();
		
		try {
			ps = con.prepareStatement(SQL_SELECTGUESTBOOKLIST);
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
			assertEquals(2, list.size());
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);	
		}
		return list;
	}

	public void testInsertGuestbook() {
		fail("Not yet implemented");
	}

	public void testSelectGuestbook() {
		fail("Not yet implemented");
	}

	public void testUpdateGuestbook() {
		fail("Not yet implemented");
	}

	public void testDeleteGuestbook() {
		fail("Not yet implemented");
	}
	
	public void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if (con != null) con.close();
			if (ps != null) ps.close();
			if (rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
