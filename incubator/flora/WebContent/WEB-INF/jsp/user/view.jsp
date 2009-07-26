<%@page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<html>
<head>
<title><fmt:message key="user.view.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="${pageContext.request.contextPath}/css/global.css" type="text/css">
<script language="JavaScript">
function userRemove() {
	if ( confirm("<fmt:message key="confirm.delete.message"/>") ) {
		f.action = "${pageContext.request.contextPath}/user/editUser.do";
		f.submit();
	}
}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
  
<!-- modify Form  -->
<form name="f" method="post">
<input type="hidden" name="userId" value="${user.userId}"/>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="BBBBBB">
  <tr>
	<td width=150 align=center bgcolor="E6ECDE" height="22">
		<fmt:message key="user.id"/>
	</td>
	<td bgcolor="ffffff" style="padding-left:10">
		${user.userId}
	</td>
  </tr>
  <tr>
	<td width=150 align=center bgcolor="E6ECDE" height="22">
		<fmt:message key="user.name"/>
	</td>
	<td bgcolor="ffffff" style="padding-left:10">
		${user.name}
	</td>
  </tr>
  <tr>
	<td width=150 align=center bgcolor="E6ECDE" height="22">
		<fmt:message key="user.email"/>
	</td>
	<td bgcolor="ffffff" style="padding-left:10">
		${user.email}
	</td>
  </tr>
  <tr>
	<td width=150 align=center bgcolor="E6ECDE" height="22">
		<fmt:message key="user.admin"/>
	</td>
	<td bgcolor="ffffff" style="padding-left:10">
<c:choose>
	<c:when test="${user.admin}">
	Y
	</c:when>
	<c:otherwise>
	N
	</c:otherwise>
</c:choose> 
	</td>
  </tr>   		  
</table>
<br/>
<table width=100% border=0 cellpadding=0 cellspacing=0>
  <tr>
	<td align=center>
	<input type="button" value="<fmt:message key="user.modify.button"/>" name="modify" 
		onClick="location.href='${pageContext.request.contextPath}/user/editUser.do?userId=${user.userId}'"> &nbsp;
	<input type="submit" value="<fmt:message key="user.delete.button"/>" name="remove" onClick="userRemove()"> &nbsp;
	<input type="button" value="<fmt:message key="user.list.button"/>" name="list" 
		onClick="location.href='${pageContext.request.contextPath}/user/listUser.do'"> 
	</td>
  </tr>
</table>
</form>
</body>
</html>