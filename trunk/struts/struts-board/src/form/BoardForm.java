package form;

import javax.servlet.http.HttpServletRequest;

import board.model.Board;

import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 * @struts:form name="boardForm"
 */
public class BoardForm extends ActionForm {
	private int fileNo = 0;
	private FormFile[] fileList = new FormFile[3];
	private Board boardValue = new Board();

	public Board getBoardValue() {
		return boardValue;
	}

	public FormFile[] getFileList() {
		return fileList;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setBoardValue(Board board) {
		boardValue = board;
	}

	public void setFileList(FormFile[] files) {
		fileList = files;
	}

	public void setFileNo(int i) {
		fileNo = i;
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		ActionErrors errors = new ActionErrors();
		int sizeOfFiles = 0;

		for (int i=0; i< fileList.length; i++){
			if ( fileList[i] != null ){
				sizeOfFiles += fileList[i].getFileSize();
			}
		}

		if (sizeOfFiles > 10*1024000) {
			errors.add("maxLengthExceeded", new ActionError("error.file.maxLengthExceeded"));
		}

		return errors;
	}
}
