package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Guestbook;


public class GuestbookDAO {

	private static final String SQL_SELECTGUESTBOOKLIST = "select * from guestbook";
	//private static final String SQL_INSERTGUESTBOOK = "insert into guestbook values (nextval('guestbook_no_seq'), ?, ?, ?, ?, ?)";
	private static final String SQL_INSERTGUESTBOOK = "insert into guestbook values (next value for GUESTBOOK_SEQ, ?, ?, ?, ?, ?)";
	private static final String SQL_SELECTGUESTBOOK = "select * from guestbook where no = ?";
	private static final String SQL_UPDATEGUESTBOOK = "update guestbook set user_id = ?, title = ?, category = ?, postdate = ?, comment = ? where no = ?";
	private static final String SQL_DELETEGUESTBOOK = "delete from guestbook where no = ?";
	
	public List selectGuestbookList(){
				
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
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);	
		}
		return list;
	}
	
	public void insertGuestbook(Guestbook guestbook) {
		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		
		try {
			ps = con.prepareStatement(SQL_INSERTGUESTBOOK);
			ps.setString(1, guestbook.getUserId());
			ps.setString(2, guestbook.getTitle());
			ps.setString(3, guestbook.getCategory());
			ps.setTimestamp(4, guestbook.getPostdate());
			ps.setString(5, guestbook.getComment());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con, ps, null);
		}
	}
	
	public Guestbook selectGuestbook (int no) {
		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Guestbook guestbook = null;
		
		try {
			ps = con.prepareStatement(SQL_SELECTGUESTBOOK);
			ps.setInt(1, no);
			
			rs = ps.executeQuery();
			
			guestbook = new Guestbook();
			guestbook.setNo(no);
			guestbook.setUserId(rs.getString("user_id"));
			guestbook.setTitle(rs.getString("title"));
			guestbook.setCategory(rs.getString("category"));
			guestbook.setPostdate(rs.getTimestamp("postdate"));
			guestbook.setComment(rs.getString("comment"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close (con, ps, rs);
		}
		
		return guestbook;
	}
	
	public void updateGuestbook (Guestbook guestbook) throws SQLException{
		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		
		try {
			ps = con.prepareStatement(SQL_UPDATEGUESTBOOK);
			ps.setString(1, guestbook.getUserId());
			ps.setString(2, guestbook.getTitle());
			ps.setString(3, guestbook.getCategory());
			ps.setTimestamp(4, guestbook.getPostdate());
			ps.setString(5, guestbook.getComment());
			ps.setInt(6, guestbook.getNo());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con, ps, null);
		}
	}
	
	public void deleteGuestbook (int no) {
		Connection con = DBConnector.getConnection();
		PreparedStatement ps = null;
		
		try {
			ps = con.prepareStatement(SQL_DELETEGUESTBOOK);
			ps.setInt(1, no);
			
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con, ps, null);
		}		
	}
		
	public void close(Connection con, PreparedStatement ps, ResultSet rs){
		try {
			if (con != null) con.close();
			if (ps != null) ps.close();
			if (rs != null) rs.close();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
