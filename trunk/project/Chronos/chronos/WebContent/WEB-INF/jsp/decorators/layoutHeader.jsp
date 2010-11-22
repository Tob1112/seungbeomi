<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<html>
<head>
	<title><decorator:title default="chronos" /></title>
	<decorator:head />
</head>
<body>
	<table>
		<tr>
			<td class="header">
				<decorator:body />
			</td>
		</tr>
	</table>
</body>
</html>