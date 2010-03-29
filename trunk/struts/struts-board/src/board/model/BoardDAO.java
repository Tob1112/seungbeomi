package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.h2.jdbcx.JdbcConnectionPool;

import util.NamingService;

/**
 * 자료실 게시판에서 데이터베이스의 접근을 전담하는 클래스.
 * BOARD, BOARDFILE 테이블과의 접근을 담당한다.
 */

/*
 *시퀀스 생성문
create sequence board_seq
increment by 1
start with 4
maxvalue 10000
nocycle
nocache

create sequence boardfile_seq
increment by 1
start with 1
maxvalue 10000
nocycle
nocache
 */
public class BoardDAO {
	//OraclePooledConnection pool = null;
	JdbcConnectionPool pool = null;

	public BoardDAO(){
		NamingService ns = NamingService.getInstance();
		//pool객체를 얻어온다.
		//pool = (OraclePooledConnection)ns.getAttribute("pool");
		pool = (JdbcConnectionPool)ns.getAttribute("pool");
	}
	/**
	 * 새로운 게시물을 추가하는 메써드.
	 * 하나의 게시물과 게시물에 첨부된 첨부파일을 추가.
	 */
	public int create(Board board) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt_b = null;
		PreparedStatement pstmt_f = null;
		try {
			StringBuffer insertQuery = new StringBuffer();
			insertQuery.append("INSERT INTO BOARD ");
			insertQuery.append("(boardno, title, name, email, ");
			insertQuery.append("password, content, createdate) ");
			insertQuery.append("VALUES(board_seq.NEXTVAL, ?, ?, ?, ?, ?, localtimestamp)");


			con = pool.getConnection();
			pstmt_b = con.prepareStatement(insertQuery.toString());


//			pstmt_b.setInt(1, boardNo);
			pstmt_b.setString(1, board.getTitle());
			pstmt_b.setString(2, board.getName());
			pstmt_b.setString(3, board.getEmail());
			pstmt_b.setString(4, board.getPassword());
			pstmt_b.setString(5, board.getContent());
//			pstmt_b.setString(7, "localtimestamp");

			int result = pstmt_b.executeUpdate();//지금 여기서 '명령문 종료'에러가 난다.


			//여기서 부터는 파일 삽입을 위한 method
			StringBuffer fileInsertQuery = new StringBuffer();
			fileInsertQuery.append("INSERT INTO BOARDFILE ");
			fileInsertQuery.append("VALUES(boardfile_seq.NEXTVAL, board_seq.CURRVAL, ?, ?)");


			pstmt_f = con.prepareStatement(fileInsertQuery.toString());

			List files = board.getBoardFiles();
			Iterator fileIter = files.iterator();

//			int boardFileNo = getBoardFileNo();

			while (fileIter.hasNext()) {
				BoardFile file = (BoardFile) fileIter.next();

//				pstmt_f.setInt(1, boardFileNo);
//				pstmt_f.setInt(2, boardNo);
				pstmt_f.setString(1, file.getFileName());
				pstmt_f.setString(2, file.getTempFileName());

				pstmt_f.executeUpdate();

//				boardFileNo++;
				result++;
			}

			pstmt_b.close();
			pstmt_f.close();
			con.close();

			return result;
		} finally {
			close(con, pstmt_b, pstmt_f);
		}
	}

	/**
	 * 게시물내용을 수정하는 메써드.
	 * 하나의 게시물수정과 게시물에 첨부된 첨부파일을 추가.
	 */
	public int update(Board board) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer updateQuery = new StringBuffer();
			updateQuery.append("UPDATE BOARD SET ");
			updateQuery.append("title=?, name=?, email=?, ");
			updateQuery.append("content=? ");
			updateQuery.append("WHERE boardno=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(updateQuery.toString());
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getEmail());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getBoardNo());

			int result = pstmt.executeUpdate();

			StringBuffer fileInsertQuery = new StringBuffer();
			fileInsertQuery.append("INSERT INTO BOARDFILE ");
			fileInsertQuery.append("VALUES(boardfile_seq.NEXTVAL, ?, ?, ?)");

			pstmt = con.prepareStatement(fileInsertQuery.toString());

			List files = board.getBoardFiles();
			Iterator fileIter = files.iterator();
//			int boardFileNo = getBoardFileNo();

			while (fileIter.hasNext()) {
				BoardFile file = (BoardFile) fileIter.next();

//				String tempFileName = Long.toString(System.currentTimeMillis());
//				String tempFileName =
//					System.currentTimeMillis() + "_" + file.getFileName();

				System.out.println("System.currentTimeMillis()는 무슨값?  "+System.currentTimeMillis());

//				pstmt.setInt(1, boardFileNo);
				pstmt.setInt(1, board.getBoardNo());
				pstmt.setString(2, file.getFileName());
				pstmt.setString(3, file.getTempFileName());

				pstmt.executeUpdate();

//				boardFileNo++;
				result++;
			}

			pstmt.close();
			con.close();

			return result;
		} finally {
			close(con, pstmt);
		}
	}

	/**
	 * 게시물을 삭제하는 메써드.
	 */
	public int remove(int boardNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer removeFileQuery = new StringBuffer();
			removeFileQuery.append("DELETE FROM BOARDFILE ");
			removeFileQuery.append("WHERE boardno=?");

			con = pool.getConnection();
			pstmt = con.prepareStatement(removeFileQuery.toString());
			pstmt.setInt(1, boardNo);

			int result = pstmt.executeUpdate();

			StringBuffer removeQuery = new StringBuffer();
			removeQuery.append("DELETE FROM BOARD ");
			removeQuery.append("WHERE boardno=?");

			pstmt = con.prepareStatement(removeQuery.toString());
			pstmt.setInt(1, boardNo);

			result += pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			close(con, pstmt);
		}
	}

	/**
	 * 게시물 번호에 해당하는 게시물 정보를 반환하는 메써드.
	 * 게시물에 첨부되어 있는 첨부파일 정보도 반환한다.
	 */
	public Board findBoard(int boardNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt_b = null;
		PreparedStatement pstmt_f = null;
		ResultSet rs = null;
		try {
			StringBuffer findQuery = new StringBuffer();
			findQuery.append("SELECT ");
			findQuery.append("title, name, email, ");
			findQuery.append("password, createdate, content, hitcount ");
			findQuery.append("FROM BOARD ");
			findQuery.append("WHERE boardno=? ");

			con = pool.getConnection();
			pstmt_b = con.prepareStatement(findQuery.toString());
			pstmt_b.setInt(1, boardNo);

			rs = pstmt_b.executeQuery();

			Board board = null;
			if (rs.next()) {
				board = new Board();
				board.setBoardNo(boardNo);
				board.setTitle(rs.getString("title"));
				board.setName(rs.getString("name"));
				board.setEmail(rs.getString("email"));
				//oracle의 datetype과의 호환을 위해 timestamp를 이용한다.
				board.setCreateDate(rs.getTimestamp("createdate"));
				board.setPassword(rs.getString("password"));
				board.setContent(rs.getString("content"));
				board.setHitCount(rs.getInt("hitcount"));
			}

			if (board != null) {
				StringBuffer findFileQuery = new StringBuffer();

				findFileQuery.append("SELECT ");
				findFileQuery.append("fileno, filename, tempfilename ");
				findFileQuery.append("FROM BOARDFILE ");
				findFileQuery.append("WHERE boardno=? ");

				//boardfile 테이블을
				pstmt_f = con.prepareStatement(findFileQuery.toString());
				pstmt_f.setInt(1, boardNo);

				rs = pstmt_f.executeQuery();

				while (rs.next()) {
					BoardFile file = new BoardFile();
					file.setFileNo(rs.getInt("fileno"));
					file.setFileName(rs.getString("filename"));
					file.setTempFileName(rs.getString("tempfilename"));

					board.addBoardFile(file);
				}
			}

			rs.close();
			pstmt_b.close();
			pstmt_f.close();
			con.close();

			return board;
		} finally {
			close(con, pstmt_b, pstmt_f, rs);
		}
	}

	/**
	 * 현재 페이지와 페이지당 카운트 수를 이용하여 해당 부분의
	 * 게시물 리스트를 반환.
	 * 게시물 리스트에는 첨부파일 정보가 필요없기 때문에 게시물 정보만 반환
	 */
	public List findBoardList(int currentPage, int countPerPage)
		throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer findQuery = new StringBuffer();
			findQuery.append("SELECT ");
			findQuery.append("boardno, title, name, email, ");
			findQuery.append("createdate, hitcount ");
			findQuery.append("FROM BOARD ");
			findQuery.append("ORDER BY CREATEDATE DESC ");

			con = pool.getConnection();


			/*
			 * -ResultSet을 스크롤을 가능하게 만들어 커서를 원하는 레코드로 옮길 수 있으며 갱신도 가능하다
			 *
			 * TYPE_SCROLL_SENSITIVE : 스크롤 가능하며 업데이트가 발생하면 바로 반영된다
			 * TYPE_SCROLL_INSENSITIVE : 스크롤 가능하며 업데이트가 발생해도 반영되지 않는다.
			 * TYPE_FORWARD_ONLY : 스크롤 되지않으며, 다음 행에만 진행된다.
			 * CONCUR_READ_ONLY : ResultSet을 갱신할 수 없으며 읽기만 가능하다
			 * CONCUR_UPDATABLE : ResultSet을 갱신할 수 있다.
			 */
			pstmt =
				con.prepareStatement(findQuery.toString(),
						ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);

			rs = pstmt.executeQuery();

			int start = ((currentPage - 1) * countPerPage) + 1;

			List boardList = new ArrayList();
			/*
			 * 이부분에서 re.absolute를 써주고 있다. 따라서
			 * JDBC 2.0에서 새롭게 추가된 기능이기 때문에, 하위호환성을 위해 Statement를 받아올 때
			 * Connection.createStatement() 대신에 Connection.createStatement(int, int)를
			 * 사용해야 합니다.
			 * 자세한 설명은 java.sql 패키지의 API 문서를 꼭 참조하십시오. 자신이 정확히
			 * 무엇을 하고 있는지를 알지 못하고 그때그때 발생하는 exception만 잡아내는
			 * 프로그래밍은 오래가지 못합니다
			 *
			 *
			 * 이 부분 페이징에서 중요하다. start에 저장된,, 즉, 선택된 페이지에 나올 글들만 추리기 위해
			 * rs.absolute를 사용하였다.
			 */
			if ((start >= 0) && rs.absolute(start)) {
				boolean hasNext = false;

				do {
					Board board = new Board();
					board.setBoardNo(rs.getInt("boardno"));
					board.setTitle(rs.getString("title"));
					board.setName(rs.getString("name"));
					board.setEmail(rs.getString("email"));
					//oracle과의 datetype를 위해 timestamp로 사용한다.
					board.setCreateDate(rs.getTimestamp("createdate"));
					board.setHitCount(rs.getInt("hitcount"));

					boardList.add(board);
				} while ((hasNext = rs.next()) && (--countPerPage > 0));
			}

			rs.close();
			pstmt.close();
			con.close();

			return boardList;
		} finally {
			close(con, pstmt, rs);
		}
	}

	/**
	 * 조회수를 1 증가.
	 */
	public int updateHitCount(int boardNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer updateQuery = new StringBuffer();
			updateQuery.append("UPDATE BOARD SET ");
			updateQuery.append("hitcount=hitcount+1 ");
			updateQuery.append("WHERE boardno=? ");

			con = pool.getConnection();
			pstmt = con.prepareStatement(updateQuery.toString());
			pstmt.setInt(1, boardNo);

			int result = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			close(con, pstmt);
		}
	}

	/**
	 * 파일 번호에 해당하는 첨부파일을 삭제
	 */
	public int removeBoardFile(int fileNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer removeFileQuery = new StringBuffer();
			removeFileQuery.append("DELETE FROM BOARDFILE ");
			removeFileQuery.append("WHERE fileno=?");

			con = pool.getConnection();
			pstmt = con.prepareStatement(removeFileQuery.toString());
			pstmt.setInt(1, fileNo);

			int result = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			return result;
		} finally {
			close(con, pstmt);
		}
	}

	private int getBoardNo() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("글쓰기 할때 getBoardNo()에 오나??");
		try {
			StringBuffer maxQuery = new StringBuffer();
			maxQuery.append("SELECT max(boardno) FROM BOARD");

			con = pool.getConnection();
			pstmt = con.prepareStatement(maxQuery.toString());
			rs = pstmt.executeQuery();

			rs.next();

			int boardNo = rs.getInt(1) + 1;

			rs.close();
			pstmt.close();
			con.close();

			System.out.println("getBoardNo에서의 boardNo는  "+ boardNo);
			return boardNo;
		} finally {
			close(con, pstmt, rs);
		}
	}

	private int getBoardFileNo() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer maxQuery = new StringBuffer();
			maxQuery.append("SELECT max(fileno) FROM BOARDFILE");

			con = pool.getConnection();
			pstmt = con.prepareStatement(maxQuery.toString());
			rs = pstmt.executeQuery();

			rs.next();
			int boardFileNo = rs.getInt(1) + 1;

			rs.close();
			pstmt.close();
			con.close();

			return boardFileNo;
		} finally {
			close(con, pstmt, rs);
		}
	}

	public int getTotalNo() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			StringBuffer maxQuery = new StringBuffer();
			maxQuery.append("SELECT count(*) FROM BOARD");

			con = pool.getConnection();
			pstmt = con.prepareStatement(maxQuery.toString());
			rs = pstmt.executeQuery();

			rs.next();
			int totalNo = rs.getInt(1);

			rs.close();
			pstmt.close();
			con.close();

			return totalNo;
		} finally {
			close(con, pstmt, rs);
		}
	}


	// connection을 끊어주는 close메소드들.. 오버로딩 되어있다.
	private void close(Connection con, PreparedStatement pstmt, ResultSet rs)
		throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (con != null){
			con.close();
		}
		if (pstmt != null){
			pstmt.close();
		}
	}

	private void close(Connection con, PreparedStatement pstmt)
		throws SQLException {
		if (pstmt != null) {
			pstmt.close();
		}

		if (con != null) {
			con.close();
		}


	}

	private void close(Connection con, PreparedStatement pstmt_b, PreparedStatement pstmt_f)
	throws SQLException {
		if (pstmt_b != null) {
			pstmt_b.close();
		}
		if (pstmt_f != null) {
			pstmt_f.close();
		}
		if (con != null) {
			con.close();
		}
	}

	private void close(Connection con, PreparedStatement pstmt_b, PreparedStatement pstmt_f, ResultSet rs)
	throws SQLException {
		if (pstmt_b != null) {
			pstmt_b.close();
		}
		if (pstmt_f != null) {
			pstmt_f.close();
		}
		if (con != null) {
			con.close();
		}
		if(rs != null){
			rs.close();
		}
	}
}
