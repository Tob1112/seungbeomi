package user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.h2.jdbcx.JdbcConnectionPool;

//import oracle.jdbc.pool.OraclePooledConnection;
import util.NamingService;


/**
 * 사용자 관리에서 데이터베이스와의 작업을 전담하는 클래스.
 * UserInfo 테이블에 사용자를 추가, 수정, 삭제, 검색등의 작업을 한다.
 */
public class UserDAO {

	//OraclePooledConnection pool = null;
	JdbcConnectionPool pool = null;

	public UserDAO(){

		NamingService ns = NamingService.getInstance();
		//pool객체를 얻어온다.
		//pool = (OraclePooledConnection)ns.getAttribute("pool");
		pool = (JdbcConnectionPool)ns.getAttribute("pool");
	}
	/**
	 * 사용자 관리 테이블에 새로운 사용자 생성.
	 */
	public int create(User user) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer insertQuery = new StringBuffer();
			insertQuery.append("INSERT INTO USERINFO VALUES ");
			insertQuery.append("(?, ?, ?, ?)");

			con = pool.getConnection();
			pstmt = con.prepareStatement(insertQuery.toString());
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getEmail());

			int result = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			if ( pstmt != null ){
				pstmt.close();
			}

			if ( con != null ){
				con.close();
			}
		}
	}

	/**
	 * 기존의 사용자 사용자 정보를 수정.
	 */
	public int update(User user) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer updateQuery = new StringBuffer();
			updateQuery.append("UPDATE USERINFO SET ");
			updateQuery.append("password=?, name=?, email=? ");
			updateQuery.append("WHERE userid=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(updateQuery.toString());
			pstmt.setString(1, user.getPassword());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getUserId());

			int result = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			if ( pstmt != null ){
				pstmt.close();
			}

			if ( con != null ){
				con.close();
			}
		}
	}

	/**
	 * 사용자 아이디에 해당하는 사용자를 삭제.
	 */
	public int remove(String userId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer removeQuery = new StringBuffer();
			removeQuery.append("DELETE FROM USERINFO ");
			removeQuery.append("WHERE userid=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(removeQuery.toString());
			pstmt.setString(1, userId);

			int result = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			if ( pstmt != null ){
				pstmt.close();
			}

			if ( con != null ){
				con.close();
			}
		}
	}

	/**
	 * 사용자 아이디 정보를 데이터베이스에서 찾아 User 도메인 클래스에
	 * 저장하여 반환.
	 */
	public User findUser(String userId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer findQuery = new StringBuffer();
			findQuery.append("SELECT ");
			findQuery.append("password, name, email ");
			findQuery.append("FROM USERINFO ");
			findQuery.append("WHERE userid=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(findQuery.toString());
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			User user = null;
			if ( rs.next() ){
				user = new User();

				user.setUserId(userId);
				user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
			}

			rs.close();
			pstmt.close();
			con.close();

			return user;

		} finally {
			if ( rs != null ){
				rs.close();
			}
			if ( pstmt != null ){
				pstmt.close();
			}
			if ( con != null ){
				con.close();
			}
		}
	}

	/**
	 * 사용자 리스트를 만들기 위한 부분으로 현재 페이지와
	 * 페이지당 카운트수를 이용하여 해당부분의 사용자만을 List콜렉션에
	 * 저장하여 반환.
	 */
	public List findUserList(int currentPage, int countPerPage)
		throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer findQuery = new StringBuffer();
			findQuery.append("SELECT ");
			findQuery.append("userid, password, name, email ");
			findQuery.append("FROM USERINFO");

			con = pool.getConnection();
			pstmt = con.prepareStatement(findQuery.toString(),
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY );

			rs = pstmt.executeQuery();

			int start = ((currentPage-1) * countPerPage) + 1;

			List userList = null;
			if ( (start >= 0) && rs.absolute(start) ) {
				boolean hasNext = false;
				userList = new ArrayList();

				do {
					User user = new User();
					user.setUserId(rs.getString("userid"));
					user.setPassword(rs.getString("password"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));

					userList.add(user);
				} while ( (hasNext = rs.next()) && (--countPerPage > 0));
			}

			rs.close();
			pstmt.close();
			con.close();

			return userList;
		} finally {
			if ( rs != null ){
				rs.close();
			}
			if ( pstmt != null ){
				pstmt.close();
			}
			if ( con != null ){
				con.close();
			}
		}
	}

	/**
	 * 인자로 전달되는 아이디를 가지는 사용자가 존재하는지의
	 * 유무를 판별.
	 */
	public boolean existedUser(String userId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer existedQuery = new StringBuffer();
			existedQuery.append("SELECT count(*) FROM USERINFO ");
			existedQuery.append("WHERE userid=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(existedQuery.toString());
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			int count = 0;
			if ( rs.next() ){
				count = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			if ( count == 1 ) {
				return true;
			} else {
				return false;
			}
		} finally {
			if ( rs != null ){
				rs.close();
			}
			if ( pstmt != null ){
				pstmt.close();
			}
			if ( con != null ){
				con.close();
			}
		}
	}
}
