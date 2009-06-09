package test.persistence;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import junit.framework.TestCase;
import model.Guestbook;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.operation.DatabaseOperation;

import persistence.DBConnector;
import persistence.GuestbookDAO;

public class GuestbookDAOTest extends TestCase {

	//enum DataType {EXCEL, FLATXML}
	
	Connection con;
	private File file;
	
	@Override
	protected void setUp() throws Exception {		
		IDatabaseConnection idbcon = null;
		
		try {
			super.setUp();
			con = DBConnector.getConnection();
			idbcon = new DatabaseConnection(con);
			
			System.out.println(" * create table start");
			/*this.update(
					"CREATE TABLE user_info ( " +
					"id varchar(20) primary key,  " +
					"pw varchar(20) NOT NULL, " +
					"name varchar(20) NOT NULL)");
			this.update(
					"CREATE TABLE guestbook ( " +
					"no int, " +
					"user_id varchar(20) NOT NULL, " +
					"title varchar(20) NOT NULL, " +
					"category varchar(20) DEFAULT 'IT', " +
					"postdate timestamp NOT NULL, " +
					"comment varchar(200), " +
					"CONSTRAINT guestbook_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info (id));");
			this.update(
					"CREATE SEQUENCE GUESTBOOK_SEQ START WITH 1");
			this.update(
					"INSERT INTO user_info VALUES ('son','son','seungbeomi') "); */
					//"SEQUENCE GUESTBOOK_SEQ START WITH 1");
			//IDataSet dataset = new FlatXmlDataSet( new FileInputStream("C:/development/workspace/guestbook/src/test/data/user_info.xml"));
			//DatabaseOperation.CLEAN_INSERT.execute(idbcon, dataset);
			
			this.update("delete from guestbook");
			this.update(
					"INSERT INTO user_info VALUES ('son','son','seungbeomi') ");
			
			System.out.println(" * create table end");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(idbcon, con, null, null);
		}
	}
	
	//use for SQL command SELECT
    public synchronized void query(String expression) throws SQLException {
    	
    	System.out.println(" * query("+expression+")");
    	
        Statement st = null;
        ResultSet rs = null;

        st = con.createStatement();  
        rs = st.executeQuery(expression);
        st.close(); 
    }

//use for SQL commands CREATE, DROP, INSERT and UPDATE
    public synchronized void update(String expression) {
    	System.out.println(" * update("+expression+")");
    	
        Statement st = null;
        try {
			st = con.createStatement();
			int i = st.executeUpdate(expression);
			if (i == -1) {
				System.out.println("db error : " + expression);
			}
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
    }    // void update()
    
	public void testGuestbookCRUD (){
		try {
			GuestbookDAO dao = new GuestbookDAO();
			assertEquals(dao.selectGuestbookList().size(),0);
			
			//insert
			dao.insertGuestbook(populateGuestbook());
			
			assertEquals(populateGuestbook().getNo(), 1);
			assertEquals(dao.selectGuestbookList().size(), 1);
	
			// update 
			dao.updateGuestbook(updateGuestbook());
			Guestbook guestbook = dao.selectGuestbook(1);
			System.out.println(guestbook);
			assertEquals(guestbook.getUserId(), "kim");
			
			System.out.println("<<< 5555");
			//delete
			dao.deleteGuestbook(1);
			assertEquals(dao.selectGuestbookList().size(), 0);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
	public void close(IDatabaseConnection idbcon, Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if (idbcon != null) idbcon.close();
			if (con != null) con.close();
			if (ps != null) ps.close();
			if (rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private Guestbook populateGuestbook() {
		Guestbook guestbook = new Guestbook();
		guestbook.setNo(1);
		guestbook.setUserId("son");
		guestbook.setTitle("test");
		guestbook.setPostdate(Timestamp.valueOf("2009-06-09 00:00:00.000000000"));
		guestbook.setCategory("test");
		guestbook.setComment("test");
		return guestbook;		
	}
	
	private Guestbook updateGuestbook() {
		Guestbook guestbook = new Guestbook();
		guestbook.setNo(1);
		guestbook.setUserId("son");
		guestbook.setTitle("updatetest");
		guestbook.setPostdate(Timestamp.valueOf("2009-06-09 00:00:00.000000000"));
		guestbook.setCategory("updatetest");
		guestbook.setComment("updatetest");
		return guestbook;		
	}
}
