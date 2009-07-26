<%@page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<html>
<head>
<title><fmt:message key="user.list.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="${pageContext.request.contextPath}/css/global.css" type="text/css">

</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
	<!-- list -->
	<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="BBBBBB">
  	<tr>
		<td width=30% align=center bgcolor="E6ECDE" height="22">
			<fmt:message key="user.id"/>
		</td>
		<td width=30% align=center bgcolor="E6ECDE">
			<fmt:message key="user.name"/>
		</td>
		<td align=center bgcolor="E6ECDE"><fmt:message key="user.email"/></td>
  	</tr>
  	
	<c:forEach items="${userList}" var="user">  	
  	<tr>
		<td width=30% align=center bgcolor="ffffff" height="20">
			${user.userId}
		</td>
		<td width=30% bgcolor="ffffff" style="padding-left:10">
			<a href="${pageContext.request.contextPath}/user/viewUser.do?userId=${user.userId}" class="user">
				${user.name}
			</a>
		</td>
		<td align=center bgcolor="ffffff">
			${user.email}
		</td>
  	</tr>
	</c:forEach>		  	
	</table>
	<!-- /list -->	 
<br>
<!-- button -->		
<table border="0" cellpadding="0" cellspacing="1" width="100%">
	<tr>
		<td align="right">
			<input type="button" value="<fmt:message key="user.add2.button"/>" name="add"
				onClick="location.href='${pageContext.request.contextPath}/user/editUser.do'"/>
		</td>
	</tr>
</table>		
</form>
</body>
</html>