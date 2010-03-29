package user.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import user.model.User;
import user.model.UserManager;
import form.UserForm;

/**
 * @struts.action path="/login" scope="request" input="/struts/login.jsp"
 *                name="userForm"
 *
 * @struts.action-forward name="user_list" path="/user_list.do" redirect="true"
 */

public class UserAction extends DispatchAction {

	private static Log log = LogFactory.getLog(UserAction.class);

	// ====================================================[login]
	public ActionForward login(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction login~~!!");

		// userForm의 객체 생성
		UserForm userForm = (UserForm)form;

		// 모델에 로그인 처리를 위임.
		UserManager manager = UserManager.instance();
		String userId = (String)userForm.getUserId();
		String password = (String)userForm.getPassword();
		manager.login(userId,password);

		// 세션에 사용자 이이디 저장.
		HttpSession session = request.getSession();
		session.setAttribute("userId", userId);

		log.debug("session에 id저장");

		// 이동할 페이지를 결정.
		return mapping.findForward("user_list");
	}

	// =================================================[insert]
	public ActionForward insert(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction insert~~!!");
		log.debug("UserAction의 insert메소드");

		User user = new User();
		user.setUserId(request.getParameter("userId"));
		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));

		UserManager manager = UserManager.instance();
		manager.create(user);

		return mapping.findForward("user_list");

	}

	// ===================================================[list]
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("Struts Test4 UserAction list~~");
		log.debug("UserAction List보자");

		// 모델에서 리스트를 뽑아오는 처리를 위임.
		UserManager manager = UserManager.instance();
		List userList = manager.findUserList(1, 20); // 보여줄 페이지 수

		// 사용자의 정보를 얻어와 사용자의 정보를 담은 객체를
		// request에 저장하여 전달하고 있다.
		request.setAttribute("userList", userList);

		// 이동할 페이지를 결정
		return mapping.findForward("user_list");

	}

	// ================================================[view]
	public ActionForward view(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction view~~!!");

		String userId = request.getParameter("userId");

		UserManager manager = UserManager.instance();
		User user = manager.findUser(userId);

		request.setAttribute("user", user);

		return mapping.findForward("user_view");
	}

	// ===========================================[UpdateForm]
	public ActionForward updateForm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction updateForm~~!!");

		String userId = request.getParameter("userId");

		// 디버깅
		// System.out.println("userId = "+userId);

		UserManager manager = UserManager.instance();
		User user = manager.findUser(userId);

		// System.out.println("findUser = "+user.getUserId()+" |
		// "+user.getPassword()+" | "+user.getName()+" | "+user.getEmail());

		request.setAttribute("user", user);

		return mapping.findForward("user_modify");
	}

	// ===========================================[update]
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction update~~!!");

		User user = new User();
		user.setUserId(request.getParameter("userId"));
		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));

		UserManager manager = UserManager.instance();
		manager.update(user);

		return mapping.findForward("user_list");
	}

	// ================================================[delete]
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("UserAction delete~~!!");

		String userId = request.getParameter("userId");

		UserManager manager = UserManager.instance();
		manager.remove(userId);

		return mapping.findForward("user_list");

	}
}
