<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="java.util.*" %>
<%@page import="user.model.*" %>
<%@ include file="loginCheck.jsp" %>

<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>

<% request.setCharacterEncoding("euc-kr"); %>
<%
List userList = (List)request.getAttribute("userList");
%>
<html>
<head>
<title>Chapter1 사용자 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel=stylesheet href="./css/user.css" type="text/css">
<script language="JavaScript">
function userCreate() {
	f.action = "user_writeForm.do";
	f.submit();
}
function boardCreate() {
	f.action = "board_writeForm.do";
	f.submit();
}
function boardList() {
	f.action = "board_list.do";
	f.submit();
}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
<br>
<form name="f" method="post" action="user_write.jsp">
<table width=780 border=0 cellpadding=0 cellspacing=0>
<tr>
	<td width="20"></td>
	<td>
	  	<!--contents-->
	  	<table width=590 border=0 cellpadding=0 cellspacing=0>
		  	<tr>
				<td bgcolor="f4f4f4" height="22">&nbsp;&nbsp;<b>사용자 관리 - 리스트</b></td>
		  	</tr>
	  	</table>  
	  	<br>
	  
	  	<!-- list -->
	  	<table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
		  	<tr>
				<td width=190 align=center bgcolor="E6ECDE" height="22">사용자 아이디</td>
				<td width=200 align=center bgcolor="E6ECDE">이름</td>
				<td width=200 align=center bgcolor="E6ECDE">이메일</td>
		  	</tr>
<%
	Iterator userIter = userList.iterator();
	
	while ( userIter.hasNext() ) {
		User user = (User)userIter.next();
%>		  	
		  	<tr>
				<td width=190 align=center bgcolor="ffffff" height="20">
					<%= user.getUserId() %>
				</td>
				<td width=200 bgcolor="ffffff" style="padding-left:10">
					<a href="user_view.do?method=view&userId=<%= user.getUserId() %>" class="user">
						<%= user.getName() %>
					</a>
				</td>
				<td width=200 align=center bgcolor="ffffff">
					<%= user.getEmail() %>
				</td>
		  	</tr>
<%
	}
%>		  	
	  	</table>
	  	<!-- /list -->	 

		<br>
		<!-- button -->
	  	<table align=center border="0" cellpadding="0" cellspacing="1" width="590">
			<tr>
				<td>
					<%--<input type="button" value="사용자 추가" onClick="userCreate()"/>
					--%>
					<html:button property="create" onclick="userCreate()">
					<bean:message key="button.user.create"/>
					</html:button>
				 &nbsp;
				
					<%--<html:link page="/board_list.do">
					<bean:message key="button.board.list"/>
					</html:link>
					--%>
					<html:button property="list" onclick="boardList()">
					<bean:message key="button.board.list"/>
					</html:button>
				 &nbsp;
				
					<%--<html:link page="/board_writeForm.do">
					<bean:message key="button.board.create"/>
					</html:link>
					--%>
					<html:button property="create" onclick="boardCreate()">
					<bean:message key="button.board.create"/>
					</html:button>
				</td>
			</tr>
		</table>		
	</td>
</tr>
</table>  
</form>
</body>
</html>