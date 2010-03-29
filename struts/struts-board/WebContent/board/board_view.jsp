<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="util.*" %>
<%@page import="board.model.BoardFile" %>

<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<html>
<head>
<title><bean:message key="page.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel=stylesheet href="./css/board.css" type="text/css">
<script language="JavaScript">
function boardUpdate() {
	f.action = "board_updateForm.do";
	f.submit();
}

function boardRemove() {
	if ( confirm("<bean:message key="board.remove.message"/>") ) {
		f.action = "board.do";
		f.submit();
	}
}

function boardList() {
	f.action = "board_list.do";
	f.submit();
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
				<b>
				<bean:message key="page.view.header"/>
				</b>
			</td>
		  </tr>
	  </table>  
	  <br>
	  
	  <!-- write Form  -->
	  <form name="f" method="post">
	  <html:hidden property="method" value="remove"/>
	  <html:hidden name="boardForm" property="boardValue.boardNo"/>	  
	  <table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.writer"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<bean:write name="boardForm" property="boardValue.name"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.email"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<bean:write name="boardForm" property="boardValue.email"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.title"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
				<bean:write name="boardForm" property="boardValue.title"/>
			</td>
		  </tr>
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.content"/>
			</td>
			<td width=490 bgcolor="ffffff" style="padding-left:10">
			
			<%--
			아래를 보면 content를 BoardUtils로 해서 개행을 주는 것을 용이하게 했다 
			이를 쓰기 위해서는 bean:define을 쓰고 jstl을 알고 있다면 jstl을 쓰는것이
			좋다고 한다. bean:define말고 다른 방법을 찾아보도록 하자
			--%>
			<bean:define id="content" name="boardForm" property="boardValue.content"/>
				<%= BoardUtils.convertHtmlBr((String)content) %>
			</td>
		  </tr>
		</table>
		<br>
		<table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
	  <logic:notEmpty name="boardForm" property="boardValue.boardFiles">
<%
int i = 1;
%>
	  	<logic:iterate id="boardFile" name="boardForm" property="boardValue.boardFiles">
<%
		String downParm = "tempFileName=" + ((BoardFile)boardFile).getTempFileName() + 
			"&fileName=" + ((BoardFile)boardFile).getFileName();
			System.out.println("파일  "+ i+ "  downParm is : "+downParm);
%>	  	
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.file"/> <%= i %>
			</td>
			<td width=390 bgcolor="ffffff" style="padding-left:10">
			<%--
			파일을 클릭하면 다운로드 되게 링크를 건다.
			--%>
				<a href="./download.do?<%= downParm %>">
					<bean:write name="boardFile" property="fileName"/>
				</a>				
			</td>
		  </tr>
<% 
i++;
%>		  	  	
	  	</logic:iterate>
	  </logic:notEmpty>		
	  </table>
	  </form>
	  <br>
	  
	  <table width=590 border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td align=center>
			<input type="button" 
				value="<bean:message key="button.modify"/>" 
				onClick="boardUpdate()"> &nbsp;
			<input type="button" 
				value="<bean:message key="button.remove"/>" 
				onClick="boardRemove()"> &nbsp;
			<input type="button" 
				value="<bean:message key="button.list"/>" 
				onClick="boardList()">
			</td>
		  </tr>
	  </table>

	  </td>
	</tr>
</table>  

</body>
</html>