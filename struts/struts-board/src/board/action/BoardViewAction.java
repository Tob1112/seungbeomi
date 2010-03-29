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
 *      path="/board_view"
 *      scope="request"
 *      validate="true"
 *
 * @struts.action-forward
 *      name="view"
 *      path="/board_view.jsp"
 */
public class BoardViewAction extends Action {
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		int boardNo = 1;
		String boardNoStr = request.getParameter("boardNo");
		if ( (boardNoStr!=null) && (!boardNoStr.equals("")) ) {
			boardNo = Integer.parseInt(boardNoStr);
		}
		
		BoardManager manager = BoardManager.instance();
		manager.updateHitCount(boardNo);
		Board board = manager.findBoard(boardNo);
		
		((BoardForm)form).setBoardValue(board);
		
		return mapping.findForward("view");
	}

}
