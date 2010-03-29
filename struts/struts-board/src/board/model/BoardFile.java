package board.model;

public class BoardFile {
	private int fileNo = 0;
	private Board board = null;
	private String fileName = null;
	private String tempFileName = null;

	public String getFileName() {
		return fileName;
	}
	
	public Board getBoard() {
		return board;
	}

	public int getFileNo() {
		return fileNo;
	}

	
	public String getTempFileName() {
		return tempFileName;
	}
	
	public void setBoard(Board board){
		this.board = board;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public void setTempFileName(String tempFileName) {
		this.tempFileName = tempFileName;
	}
}