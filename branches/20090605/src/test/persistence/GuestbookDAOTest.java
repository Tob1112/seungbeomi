package test.persistence;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;
import model.Guestbook;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.ITable;
import org.dbunit.dataset.xml.FlatXmlDataSet;

import persistence.DBConnector;
import persistence.GuestbookDAO;

public class GuestbookDAOTest extends TestCase {

	private File file;
	
	/*
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
	*/

	public void testInsertGuestbook() {
		GuestbookDAO dao = new GuestbookDAO();
		dao.insertGuestbook(populateGuestbook());
		
		IDatabaseConnection idbcon = null;
		
		try {
			Connection con = DBConnector.getConnection();
			idbcon = new DatabaseConnection(con);
			IDataSet dataset = idbcon.createDataSet();
			ITable actualTable = dataset.getTable("guestbook");
			IDataSet expectedDataSet = new FlatXmlDataSet(new FileInputStream("C:/development/workspace/guestbook/src/test/data/insertGuestbook.xml"));
			ITable expectedTable = expectedDataSet.getTable("guestbook");
			assertEquals(expectedTable, actualTable);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(idbcon, null, null);
		}		
	}

	public void testSelectGuestbook() {
	}

	public void testUpdateGuestbook() {
	}

	public void testDeleteGuestbook() {
	}
	
	public void close(IDatabaseConnection idbcon, PreparedStatement ps, ResultSet rs) {
		try {
			if (idbcon != null) idbcon.close();
			if (ps != null) ps.close();
			if (rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//assertEquals(1, userDAO.insert(user));
	
	private Guestbook populateGuestbook() {
		Guestbook guestbook = new Guestbook();
		//guestbook.setNo(1);
		guestbook.setUserId("son");
		guestbook.setTitle("test");
		guestbook.setPostdate(Timestamp.valueOf("2009-06-09 00:00:00.000000000"));
		guestbook.setCategory("test");
		guestbook.setComment("test");
		return guestbook;		
	}
}
