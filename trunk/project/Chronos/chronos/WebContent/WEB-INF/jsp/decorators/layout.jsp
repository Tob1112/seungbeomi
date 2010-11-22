<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><decorator:title default="タイトルを入力してください。" /></title>
	<link href="<%= request.getContextPath() %>/css/main.css" rel="stylesheet" type="text/css"/>
	<decorator:head />
</head>
<body leftmargin="0" topmargin="0">
	<table width="100%" height="100%">
		<tr>
			<td id="header" colspan="2" height="30">
				<page:applyDecorator page="/WEB-INF/jsp/decorators/header.jsp" name="header" />
			</td>
		</tr>
		<tr>
			<td valign="top" width="200">
				<page:applyDecorator page="/WEB-INF/jsp/decorators/menu.jsp" name="panel" />
			</td>
			<td width="*">
				<table width="100%" height="100%" cellspacing="0">
					<tr>
						<td id="pageTitle">
							<decorator:title />
						</td>
					</tr>
					<tr>
						<td valign="top" height="100%">
							<decorator:body />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td id="footer" height="20" colspan="2">
				<page:applyDecorator page="/WEB-INF/jsp/decorators/footer.jsp" name="footer" />
			</td>
		</tr>
	</table>
</body>
</html>