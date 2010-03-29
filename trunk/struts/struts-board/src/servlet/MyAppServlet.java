package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.config.ModuleConfig;
import org.apache.struts.util.RequestUtils;

/**
 * @web.servlet name="action" 
 * 				display-name="Struts Action Servlet"
 * 				load-on-startup="1" 
 * @web.servlet-init-param 	name="config" 
 * 							value="/WEB-INF/struts-config.xml"
 * @web.servlet-init-param 	name="debug" 
 * 							value="0"
 * 
 * @web.servlet-mapping url-pattern="*.do"
 */



/**
 * @author Administrator
 * 이 class는 서버의 재시작이 없이도 sturts-config.xml과 메시지 리소스 파일의
 * 수정 사항을 애플리케이션이 인식할 수 있게 하는 것이다.
 * 이 기능을 구현하기 위해서는 ActionServlet을 상속하여 해결할 수 있다.
 * 
 * 서버의 재시작이 없어야하기 때문에 애플리케이션에 struts-config.xml과 메시지 리소스
 * 파일을 초기화하라는 요청을 해야한다. 이곳에서 구현하는 예제는 초기화를 위한 요청으로
 * reload.do를 사용하였다.
 * 즉 요청 URL에 'reload.do'가 포함되어 있다면 초기화를 진행하고 
 * 'reload.do'가 포함되어있지 않다면 ActionServlet의 process()메소드를 호출하여 요청을
 * 처리하게 구현하였다.
 */
public class MyAppServlet extends ActionServlet {

	protected void process(
		HttpServletRequest request,
		HttpServletResponse response)
		throws IOException, ServletException {
		String uri = request.getRequestURI();

		if ((uri.indexOf("reload.do") != (-1))) {
			init();

			RequestUtils.selectModule(request, getServletContext());
			ModuleConfig config = getModuleConfig(request);
			getRequestProcessor(config).init(this, config);

			RequestDispatcher dispatcher =
				request.getRequestDispatcher("/reload.jsp");
			dispatcher.forward(request, response);
		} else {
			super.process(request, response);
		}
	}
}
