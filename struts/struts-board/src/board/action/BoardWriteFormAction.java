package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @struts.action
 * 		name="boardForm"
 *      path="/board_writeForm"
 *      scope="request"
 *      validate="true"
 *
 * @struts.action-forward
 *      name="write"
 *      path="/board_write.jsp"
 */
public class BoardWriteFormAction extends Action {
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
			
		return mapping.findForward("write");
	}
}
