package form;

import java.util.List;

import org.apache.struts.action.ActionForm;

/**
 * @struts:form name="listForm"
 */
public class ListForm extends ActionForm{
	private int currentPage = 1;
	private int countPerPage = 10;
	private int startPage = 1;
	private int endPage = 1;
	private int topNo = 1;
	private List boardLists = null;

	public List getBoardLists() {
		return boardLists;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getTopNo() {
		return topNo;
	}

	public void setBoardLists(List list) {
		boardLists = list;
	}

	public void setCountPerPage(int i) {
		countPerPage = i;
	}

	public void setCurrentPage(int i) {
		currentPage = i;
	}

	public void setEndPage(int i) {
		endPage = i;
	}

	public void setStartPage(int i) {
		startPage = i;
	}

	public void setTopNo(int i) {
		topNo = i;
	}

}
