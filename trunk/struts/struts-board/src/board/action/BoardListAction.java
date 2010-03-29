package board.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import form.ListForm;
import board.model.BoardManager;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @struts.action
 *      name="listForm"
 *      path="/board_list"
 *      scope="request"
 *      validate="true"
 *
 * @struts.action-forward
 *      name="list"
 *      path="/board_list.jsp"
 */
public class BoardListAction extends Action {
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response)
		throws Exception {
		ListForm listForm = (ListForm) form;

		BoardManager manager = BoardManager.instance();
		List boardList =
			manager.findBoardList(
				listForm.getCurrentPage(),
				listForm.getCountPerPage());

		int totalNo = manager.getTotalNo();
		setTopNo(totalNo, listForm);
		endPage(totalNo, listForm);

		listForm.setBoardLists(boardList);

		return mapping.findForward("list");
	}

	private void setTopNo(int totalNo, ListForm listForm) {
		int topNo = totalNo
			- (listForm.getCurrentPage() - 1) * (listForm.getCountPerPage());
		listForm.setTopNo(topNo);
	}

	private void endPage(int totalNo, ListForm listForm) {
		int countPerPage = listForm.getCountPerPage();
		int extra = totalNo % countPerPage;

		if ( extra > 0 ){
			listForm.setEndPage((totalNo - extra )/countPerPage + 1);
		} else {
			listForm.setEndPage(totalNo/countPerPage);
		}
	}
}
