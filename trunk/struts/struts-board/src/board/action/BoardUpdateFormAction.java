package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import form.BoardForm;
import board.model.Board;
import board.model.BoardManager;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @struts.action
 * 		name="boardForm"
 *      path="/board_updateForm"
 *      scope="request"
 *      validate="true"
 *
 * @struts.action-forward
 *      name="modify"
 *      path="/board_modify.jsp"
 */
public class BoardUpdateFormAction extends Action{
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		BoardForm boardForm = (BoardForm)form;
		int boardNo = boardForm.getBoardValue().getBoardNo();
		
		BoardManager manager = BoardManager.instance();
		Board board = manager.findBoard(boardNo);		
		
		boardForm.setBoardValue(board);
		
		return mapping.findForward("modify");
	}
}
