package processor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.RequestProcessor;



/**
 * @author Administrator
 *
 * @author Administrator
 *한글 인코딩 변환을 처리하는 클래스 이다.
 *서블릿 2.3d을 지원하는 애플리케이션 서버가 아.니.라.면.
 *filter을 사용하지못하므로 이 클래스를 사용하여야한다.
 *<!--
 *
	web.xml에는 이걸....
	<servlet>
      	<servlet-name>action</servlet-name>
      	<servlet-class>servlet.MyAppServlet</servlet-class>

      	<init-param>
        	 <param-name>config</param-name>
         	<param-value>/WEB-INF/struts-config.xml</param-value>
      	</init-param>
      	<init-param>
         	<param-name>debug</param-name>
         	<param-value>0</param-value>
      	</init-param>

      	<load-on-startup>1</load-on-startup>
   	</servlet>
	-->
	
	struts-config.xml에는 이걸 추가해 주어야한다.
	<!--
	<controller contentType="text/html"
				debug="3"
				nocache="true"
				processorClass="processor.MyAppRequestProcessor"/>
	-->
 */
public class MyAppRequestProcessor extends RequestProcessor {

	protected boolean processPreprocess(
		HttpServletRequest request,
		HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("euc-kr");			
			
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
