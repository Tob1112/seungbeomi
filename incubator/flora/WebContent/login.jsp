<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Flora Project login</title>
</head>
<body>
	<h1>Flora Project</h1>
	<form action="login" method="post">
		<table border="1">
			<tr>
				<th>floraId</th>
				<td><input type="text" name="floraId"></td>
			</tr>
			<tr>
				<th>password</th>
				<td><input type="password" name="password"></td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="submit" value="login">
					<input type="reset" value="reset">
				</td>
			</tr>		
		</table>
	</form>
</body>
</html>