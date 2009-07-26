<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<form action="${pageContext.request.contextPath}/user/login.do"
	id="thisform" method="post" name="authenticationForm">
	<legend>Login</legend>
		<p>
			<label>user id :</label><br />
			<input type="text" id="userId"/>
		</p>
		<p>
			<label>password :</label><br />
			<input type="password" id="password"/>
		</p>
		<p>
			<center>
				<input type="submit" name="login" value="login"/>&nbsp;
				<input type="button" value="register"
					onClick="location.href='${pageContext.request.contextPath}/user/editUser.do'" />
			</center>
		</p>
</form>
</div>


