<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<html>
<head>
	<title><decorator:title default="Chronos" /></title>
	<decorator:head />
</head>
<body>
	<table>
		<tr>
			<td class="footer">
				<decorator:body />
			</td>
		</tr>
	</table>
</body>
</html>