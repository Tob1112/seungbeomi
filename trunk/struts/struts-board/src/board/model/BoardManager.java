package board.model;

import java.sql.SQLException;
import java.util.List;

public class BoardManager {
	private BoardManager() {
	}

	public static BoardManager instance() {
		return (new BoardManager());
	}

	public int create(Board board) throws SQLException {
		return getBoardDAO().create(board);
	}
	
	public int update(Board board) throws SQLException {
		return getBoardDAO().update(board);
	}	
	
	public int remove(int boardNo) throws SQLException {
		return getBoardDAO().remove(boardNo);
	}
	
	public Board findBoard(int boardNo) throws SQLException {
		return getBoardDAO().findBoard(boardNo);
	}	
	
	public List findBoardList(int currentPage, int countPerPage)
		throws SQLException {
		return getBoardDAO().findBoardList(currentPage, countPerPage);
	}

	public int updateHitCount(int boardNo) throws SQLException {
		return getBoardDAO().updateHitCount(boardNo);
	}

	public int removeBoardFile(int fileNo) throws SQLException {
		return getBoardDAO().removeBoardFile(fileNo);
	}
	
	public int getTotalNo() throws SQLException {
		return getBoardDAO().getTotalNo();
	}	
	
	private BoardDAO getBoardDAO() {
		return new BoardDAO();
	}
}
