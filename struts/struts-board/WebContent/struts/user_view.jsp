<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="user.model.*" %>
<%@ include file="loginCheck.jsp" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
User user = (User)request.getAttribute("user");
%>
<html>
<head>
<title>Chapter1 ����� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel=stylesheet href="./css/user.css" type="text/css">
<script language="JavaScript">
function userList() {
	f.action = "user_list.do?method=list";
	f.submit();
}

function userModify() {
	f.action = "user_modifyForm.do?method=updateForm";
	f.submit();
}

function userRemove() {
	if ( confirm("���� �����Ͻðڽ��ϱ�?") ) {
		f.action = "user_remove.do?method=delete";
		f.submit();
	}
}
</script>
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
<br>
<table width=780 border=0 cellpadding=0 cellspacing=0>
	<tr>
	  <td width="20"></td>
	  <td>
  <!--contents-->
	  <table width=590 border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td bgcolor="f4f4f4" height="22">&nbsp;&nbsp;<b>����� ���� - ����� ��������</b></td>
		  </tr>
	  </table>  
	  <br>
	  
	  <!-- write Form  -->
	  <form name="f" method="post">
	  <input type="hidden" name="command"/>
	  <input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
	  <table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">����� ���̵�</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<%= user.getUserId() %>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">�̸�</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<%= user.getName() %>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">�̸��� �ּ�</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<%= user.getEmail() %>
			</td>
		  </tr>		  
	  </table>
	  </form>
	  <br>
	  
	  <table width=590 border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td align=center>
			<input type="button" value="����" onClick="userModify()"> &nbsp;
			<input type="button" value="����" onClick="userRemove()"> &nbsp;
			<input type="button" value="���" onClick="userList()"> 
			</td>
		  </tr>
	  </table>

	  </td>
	</tr>
</table>  

</body>
</html>