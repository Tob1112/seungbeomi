package board.action;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import form.BoardForm;
import board.model.Board;
import board.model.BoardFile;
import board.model.BoardManager;
import util.FileUploadUtil;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.upload.FormFile;

/**
 * Xdoclet사용을 위한 태그
 * @struts.action
 *      name="boardForm"
 *      parameter="method"
 *      path="/board"
 *      scope="request"
 *      validate="true"
 *
 * @struts.action-forward
 *      name="list"
 *      path="/board_list.do"
 *      redirect="true"
 */

public class BoardAction extends DispatchAction {
	public ActionForward create(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		Board board = processBoard(form);

		BoardManager manager = BoardManager.instance();
		manager.create(board);

		return mapping.findForward("list");
	}

	public ActionForward update(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		Board board = processBoard(form);

		BoardManager manager = BoardManager.instance();
		manager.update(board);

		return mapping.findForward("list");
	}


	/**
	 * 자료실게시판의 쓰기,수정이 일어날때마다 호출되어
	 * 이안에서는 FileUploadUtil클래스의 doFileUpload()를 호출하여
	 * 파일을 업로드 시킨다 업로드된 파일의 이름은 System.currentTimeMillis()로 주어지며
	 * DB에는 실제파일의 이름이 올라간다.
	 */
	private Board processBoard(ActionForm form)
		throws
			IllegalAccessException,
			InvocationTargetException,
			NoSuchMethodException,
			FileNotFoundException,
			IOException {
		//폼을 받아와
		BoardForm boardForm = (BoardForm) form;
		Board board = boardForm.getBoardValue();

		FormFile[] fileList = boardForm.getFileList();

		for (int i = 0; i < fileList.length; i++) {
			FormFile formFile = fileList[i];

			if ( formFile != null ){
				String fileName = formFile.getFileName();

				if ((fileName != null) && (!fileName.equals("")) ) {
					BoardFile boardFile = FileUploadUtil.doFileUpload(formFile);
					board.addBoardFile(boardFile);
				}
			}
		}

		return board;
	}

	public ActionForward remove(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		BoardForm boardForm = (BoardForm)form;
		int boardNo = boardForm.getBoardValue().getBoardNo();

		BoardManager manager = BoardManager.instance();
		manager.remove(boardNo);

		return mapping.findForward("list");
	}
}
