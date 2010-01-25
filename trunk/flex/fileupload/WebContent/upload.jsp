<%@ page language="java" contentType="text/html; charset=windows-31j"
	pageEncoding="windows-31j"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-31j"/>
	<title>ファイルのアップロード</title>
</head>
<body>
	<form method="POST" enctype="multipart/form-data" action="upload">
	ファイルパス：
	<input type="file" name="fl" size="75" />
	<input type="submit" value="アップロード" />
	</form>
</body>
</html>
