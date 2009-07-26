<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="http://www.springmodules.org/tags/commons-validator"
	prefix="v"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
<head>
<title><fmt:message key="user.modify.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript">
function validateEdit(userForm) {
	if( validateUser(userForm) ) {
		if( userForm.password.value != userForm.password2.value ) {
			alert("<fmt:message key="error.input.password.mismath"/>");
			return false;
		}
		
		return true;	
	} else {
		return false;
	}
}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0
	marginwidth=0 marginheight=0>

<!-- write Form  -->
<form name="userForm" method="post"
	action="${pageContext.request.contextPath}/user/editUser.do"
	onsubmit="return validateEdit(this)">
<c:if test="${not empty existedUserException }">
<br/>
<p><b><fmt:message key="error.message"/></b> : 
<span class="fieldError"><c:out value="${existedUserException.message}"/></span>
</p>
</c:if>
<table border="0" cellpadding="0" cellspacing="1" width="100%"
	bgcolor="BBBBBB">
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.id"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10">
		<spring:bind path="user.userId">
			<input type="text" style="width:150" name="userId" value="${status.value}" />
			<span class="fieldError">${status.errorMessage}</span>
		</spring:bind>
		</td>
	</tr>
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.password"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10"><spring:bind
			path="user.password">
			<input type="password" style="width:150" name="password"
				value="${status.value}" />
			<span class="fieldError">${status.errorMessage}</span>
		</spring:bind></td>
	</tr>
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.password2"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10"><spring:bind
			path="user.password2">
			<input type="password" style="width:150" name="password2"
				value="${status.value}" />
			<span class="fieldError">${status.errorMessage}</span>
		</spring:bind></td>
	</tr>	
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.name"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10"><spring:bind
			path="user.name">
			<input type="text" style="width:240" name="name"
				value="${status.value}" />
			<span class="fieldError">${status.errorMessage}</span>
		</spring:bind></td>
	</tr>
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.email"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10"><spring:bind
			path="user.email">
			<input type="text" style="width:240" name="email"
				value="${status.value}" />
			<span class="fieldError">${status.errorMessage}</span>
		</spring:bind></td>
	</tr>
	<c:if test="${ loginUser.admin }">
	<tr>
		<td width=150 align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.admin"/>
		</td>
		<td bgcolor="ffffff" style="padding-left:10">
			<spring:bind path="user.admin">
				<c:if test="${ user.admin }">
					<input type="checkbox" name="admin" value="true" checked />
				</c:if>
				<c:if test="${ not user.admin }">
					<input type="checkbox" name="admin" value="true" />
				</c:if>
			</spring:bind>
		</td>
	</tr>
	</c:if>
</table>
<br />
<table width=100% border=0 cellpadding=0 cellspacing=0>
	<tr>
		<td align=center>
		<c:choose>
		<c:when test="${mode == 'modify'}">
			<input type="submit" value="<fmt:message key="user.modify.button"/>" name="modify"/>
		</c:when> 
		<c:otherwise>
			<input type="submit" value="<fmt:message key="user.add.button"/>" name="add"/>
		</c:otherwise>  
		</c:choose>
		<c:if test="${loginUser.admin}">		
		&nbsp;
		<input type="button" value="<fmt:message key="user.list.button"/>"
			onClick="location.href='${pageContext.request.contextPath}/user/listUser.do'">
		</c:if>
		</td>
	</tr>
</table>
</form>

<v:javascript formName="user" staticJavascript="false" xhtml="true"
	cdata="false" />
<script type="text/javascript">
	<v:javascript dynamicJavascript="false" staticJavascript="true"/>
</script>
</body>
</html>
