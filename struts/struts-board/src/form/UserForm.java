package form;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class UserForm extends ActionForm{

	private String userId;
	private String password;
	private String name;
	private String eamil;

	private static Log log = LogFactory.getLog(UserForm.class);

	/*
	 * 폼을 초기화 시켜준다. default value를 설정 할 수도 있다.
	 * 요청 스코프의 ActionForm은 매 요청마다 새로 인스턴스가 생성되는데
	 * 새 인스턴스가 생성될 때 필드들이 초기화되기 때문이다.
	 * 원래는 부모 reset()메소드를 오버라이드 하지않아도 된다.
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request){

		userId = null;
		password = null;
		name = null;
		eamil = null;

		log.trace("reset");//디버깅...
	}

	/*
	 * Http요청으로 보낸 프로퍼티들을 검증한다.
	 * 검증에러가 발생한 경우 검증 에러들을 추상화한
	 * ActionError객체를 반환한다. 아무 에러도 없는경후
	 * 빈 ActionErrors객체를 반환한다.
	 *
	 *
	 * 그리고 주의 해야할 것은 validate 메소드를 구현 해놓구
	 * struts-config.xml에서 validate=false로 해놓지 않으면
	 * default가 true이므로 모든 곳에서 validate를 수행해 exception이
	 * 발생하므로 주의 하자
	 *
	 */
//	public ActionErrors validate(
//						ActionMapping mapping,
//						HttpServletRequest request){
//		/*
//		 * ActionFrom이 검증 에러를 하나 이상 감지한 경우 ActionForm은 input 속성에 설정해 놓은
//		 * 자원(주로 페이지)으로 되돌린다.
//		 */
//		ActionErrors errors = new ActionErrors();
//
//		/*
//		 * 폼의 조건의 if절에 만족하면(즉, 원하지 않는 값이면) error를 발생한다.
//		 * 그리고 아래의 error를 properties 에 정의해준다.
//		 * error가 발생하면 resource bundle에서 key 값을 찾으므로
//		 * resource.application.properties파일에 설정해주어야 한다.
//		 */
//		if(userId == null || userId.trim().equals("")){
//			errors.add("userId", new ActionError("userRegistration.userId.problem"));
//		}
//
//		if(password == null || password.trim().equals("")){
//			errors.add("password", new ActionError("userRegistration.password.problem"));
//		}
//		return errors;
//	}
//


	public String getEamil() {
		return eamil;
	}

	public void setEamil(String eamil) {
		this.eamil = eamil;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}





}
