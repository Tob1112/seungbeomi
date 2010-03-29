package board.model;

import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;

public class Board {
	private int boardNo = 0;
	private String title = null;
	private String name = null;
	private String email = null;
	private String password = null;
	private Timestamp createDate = null;
	private String content = null;
	private int hitCount = 0;
	private List files = null;

	public Board() {
		files = new ArrayList();
	}

	//이게 왜 필요한 걸까..
	public void addBoardFile(BoardFile boardFile){
		boardFile.setBoard(this);
		files.add(boardFile);
	}

	public List getBoardFiles (){
		return files;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public String getContent() {
		return content;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	//board_list.jsp가 날자를 뿌려줄때는 전부 보여줄 필요없으니 잘라서 보내주도록 하자.
	public String getParseCreateDate() {
		System.out.println(getCreateDate().toString());
		return getCreateDate().toString();
	}

	public String getEmail() {
		return email;
	}

	public int getHitCount() {
		return hitCount;
	}

	public String getName() {
		return name;
	}

	public String getPassword() {
		return password;
	}

	public String getTitle() {
		return title;
	}

	public void setBoardNo(int i) {
		boardNo = i;
	}

	public void setContent(String string) {
		content = string;
	}

	//여기 부분 oracle에서의 datetype을 쓰기 위해 같이 바꿔주었다.
	public void setCreateDate(Timestamp stamp) {
		createDate = stamp;
	}

	public void setEmail(String string) {
		email = string;
	}

	public void setHitCount(int i) {
		hitCount = i;
	}

	public void setName(String string) {
		name = string;
	}

	public void setPassword(String string) {
		password = string;
	}

	public void setTitle(String string) {
		title = string;
	}
}
