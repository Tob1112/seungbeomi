<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<div id="menu">
<fieldset><legend>Menu</legend>
	<ul>		
	 	<li>
	 		<a href="${pageContext.request.contextPath}/index.html">
	 			<fmt:message key="app.home"/>
	 		</a>
	 	</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/board.do">
				<fmt:message key="app.board"/>
			</a>
		</li>
<c:if test="${loginUser.admin}">
		<li>
			<a href="${pageContext.request.contextPath}/user/listUser.do">
				<fmt:message key="app.user"/>
			</a>
		</li>
</c:if>		
		<li>
			<a href="http://www.javajigi.net" target="_blank">
				<fmt:message key="app.community"/>
			</a>
		</li>
		<li>
			<a href="http://wiki.javajigi.net" target="_blank">
				<fmt:message key="app.wiki"/>
			</a>
		</li>
	</ul>
</fieldset>	
</div>
