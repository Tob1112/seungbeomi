package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * web.xml 의 servlet filter 정보
 * <filter>
 * 	<display-name>Encoding Filter</display-name>
 *  <filter-name>Encoding Filter</filter-name>
 * 	<filter-class>net.javajigi.filter.EncodingFilter</filter-class>
 * 	<init-param>
 * 		<param-name>encoding</param-name>
 * 		<param-value>EUC-KR</param-value>
 * 	</init-param>
 * </filter>
 *
 * <filter-mapping>
 * 	<filter-name>Encoding Filter</filter-name>
 * 	<url-pattern>/*</url-pattern>
 * </filter-mapping>
 * */

public class EncodingFilter implements Filter{

	private String encoding = null;

	protected FilterConfig filterConfig = null;

	public void destroy(){
		this.encoding = null;
		this.filterConfig = null;
	}

	/**
	 * ServletRequest 객체에 web.xml에서 전달된 인코딩을 설정하는 메소드
	 * */
	public void doFilter(
			ServletRequest request,
			ServletResponse response,
			FilterChain chain)
	throws IOException, ServletException{
		if (request.getCharacterEncoding()==null) {
			if (encoding != null) {
				request.setCharacterEncoding(encoding);
			}
		}
		chain.doFilter(request, response);
	}

	/**
	 * web.xml에서 전달된 인코딩 값을 초기화하는 메소드
	 * */
	public void init(FilterConfig filterConfig) throws ServletException{
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
	}

	public FilterConfig getFilterConfig(){
		return filterConfig;
	}

	public void setFilterConfig(FilterConfig cfg){
		filterConfig = cfg;
	}
}
