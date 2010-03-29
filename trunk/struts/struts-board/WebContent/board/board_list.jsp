<%@page contentType="text/html;charset=euc-kr" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<html>
<%System.out.println("borad_list.jsp입장"); %>

<head>
<title><bean:message key="page.title"/></title>
<link rel=stylesheet href="./css/board.css" type="text/css">

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
					<b><bean:message key="page.list.header"/></b>
				</td>
		  	</tr>
	  	</table>  
	  	<br>
	  
	  	<!-- list -->
	  	<table border="0" cellpadding="0" cellspacing="1" width="590" bgcolor="BBBBBB">
		  	<tr>
				<td width=340 align=center bgcolor="E6ECDE">
					<bean:message key="board.title"/>
				</td>
				<td width=100 align=center bgcolor="E6ECDE">
					<bean:message key="board.writer"/>
				</td>
				<td width=100 align=center bgcolor="E6ECDE">
					<bean:message key="board.createdate"/>
				</td>
				<td width=50 align=center bgcolor="E6ECDE">
					<bean:message key="board.hitcount"/>
				</td>				
		  	</tr>		

			<logic:notEmpty name="listForm" property="boardLists">												
				<logic:iterate id="board" name="listForm" property="boardLists">
			  	<tr>
					<td width=340 bgcolor="ffffff" style="padding-left:10">
					<html:link page="/board_view.do" paramId="boardNo" 
						paramName="board" paramProperty="boardNo">
					<bean:write name="board" property="title"/>
					</html:link>
					</td>
					<td width=100 align=center bgcolor="ffffff">
					<bean:write name="board" property="name"/>
					</td>
					<td width=100 bgcolor="ffffff" style="padding-left:10">
					
					<bean:write name="board" property="parseCreateDate"/>
					<%--이부분 createDate가 아니고 parseCreateDate임을 주의 하자--%>
					</td>
					<td width=50 align=center bgcolor="ffffff">
					<bean:write name="board" property="hitCount"/>
					</td>				
			  	</tr>					
				</logic:iterate>
			</logic:notEmpty>	  	
	  	</table>
	  	<!-- /list -->	
	  	<br> 
	  	<table border="0" cellpadding="0" cellspacing="1" width="590">
			<tr>
				<td align="center">
				
				
		<%--빈의 property로 부터 listForm에 저장된 endPage를 가져와 이걸이용해 페이징을 한다--%>
		<bean:define id="endPageStr" name="listForm" property="endPage"/>
<%
int endPage = ((Integer)endPageStr).intValue();

for (int i=0; i < endPage; i++) {
%>				
				<a href="./board_list.do?currentPage=<%= (i+1) %>&countPerPage=10">
					<%= (i+1) %>
				</a>
<%
}
%>				
				</td>
			</tr>
		</table>
		<br>
		<!-- button -->
	  	<table border="0" cellpadding="0" cellspacing="1" width="590">
			<tr>
				<td align="right">
				<html:link page="/board_writeForm.do">
					<bean:message key="button.create"/>
				</html:link>
				</td>
			</tr>
		</table>		
	</td>
</tr>
</table>  
</body>
</html>