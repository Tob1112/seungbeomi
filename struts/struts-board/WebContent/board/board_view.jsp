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
			�Ʒ��� ���� content�� BoardUtils�� �ؼ� ������ �ִ� ���� �����ϰ� �ߴ� 
			�̸� ���� ���ؼ��� bean:define�� ���� jstl�� �˰� �ִٸ� jstl�� ���°���
			���ٰ� �Ѵ�. bean:define���� �ٸ� ����� ã�ƺ����� ����
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
			System.out.println("����  "+ i+ "  downParm is : "+downParm);
%>	  	
		  <tr>
			<td width=100 align=center bgcolor="E6ECDE" height="22">
				<bean:message key="board.file"/> <%= i %>
			</td>
			<td width=390 bgcolor="ffffff" style="padding-left:10">
			<%--
			������ Ŭ���ϸ� �ٿ�ε� �ǰ� ��ũ�� �Ǵ�.
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