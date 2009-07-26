<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<div id="authentication">
<form action="${pageContext.request.contextPath}/user/login.do"
	id="thisform" method="post" name="authForm">
	<fieldset>
		<legend><fmt:message key="user.logout.title"/></legend>	
		<input type="hidden" name="userId" value="${loginUser.userId}"/>		
		<p>${loginUser.name} <fmt:message key="login.welcome.message"/></p>
		<p>
			<center>
				<input type="submit" name="logout" value="<fmt:message key="user.logout.button"/>"/>&nbsp;
				<input type="button" value="<fmt:message key="user.modify.button"/>"
					onClick="location.href='${pageContext.request.contextPath}/user/editUser.do?userId=${loginUser.userId}'" />
			</center>
		</p>
	</fieldset>
</form>
</div>