<%@page contentType="text/html;charset=euc-kr" %>

<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<html>
<head>
<title><bean:message key="page.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel=stylesheet href="./css/board.css" type="text/css">
<script language="JavaScript">
function boardList() {
	boardForm.action = "board_list.do";
	boardForm.submit();
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
			<td bgcolor="f4f4f4" height="22">&nbsp;&nbsp;
				<b><bean:message key="page.write.header"/></b>
			</td>
		  </tr>
	  </table>  
	  <br>
	  
	  <!-- write Form  -->
	  
	  <!-- file을 올리기 위해서 enctype를 multipart/form-date로 해주었다. -->
	  
	  <html:form action="/board.do" method="post" enctype="multipart/form-data">
	  <html:hidden property="method" value="create"/>
	  <table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.writer"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:text style="width:150" name="boardForm" property="boardValue.name"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.password"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:password style="width:150" name="boardForm" property="boardValue.password"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.email"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:text style="width:150" name="boardForm" property="boardValue.email"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.title"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:text style="width:300" name="boardForm" property="boardValue.title"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.content"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:textarea rows="15" cols="60" name="boardForm" property="boardValue.content"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.file"/> 1</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:file style="width:400" name="boardForm" property="fileList[0]"/>
			</td>
		  </tr>	
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.file"/> 2
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:file style="width:400" name="boardForm" property="fileList[1]"/>
			</td>
		  </tr>	
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.file"/> 3
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<html:file style="width:400" name="boardForm" property="fileList[2]"/>
			</td>
		  </tr>			  		  	  	  
	  </table>
	  <br>
	  
	  <table width=590 border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td align=center>
			<html:submit property="create">
				<bean:message key="button.board.create"/>
			</html:submit>
			&nbsp;
			<html:button property="list" onclick="boardList()">
				<bean:message key="button.board.list"/>
			</html:button>
		  </tr>
	  </table>	  
	  </html:form>
	  </td>
	</tr>
</table>  

</body>
</html>