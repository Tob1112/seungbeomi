package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import form.BoardForm;
import board.model.BoardManager;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * Xdoclet사용을 위한 태그
 * @struts.action
 * 	    name="boardForm"
 *      path="/board_fileremove"
 *      scope="request"
 *      validate="true"
 * @struts.action-forward
 *      name="modify"
 *      path="/board_updateForm.do"
 * 		redirect="false"
 */
public class BoardFileRemoveAction extends Action {
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		BoardForm boardForm = (BoardForm) form;

		BoardManager manager = BoardManager.instance();
		manager.removeBoardFile(boardForm.getFileNo());

		return mapping.findForward("modify");
	}
}
