<%@ page language="java" contentType="text/html; charset=Windows-31J" pageEncoding="Windows-31J"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>SpringSecurity Sample</title></head>
<body>
一般ユーザーコンテンツ<br><br>
このページは、一般ユーザーと管理者権限があるユーザーが閲覧することが出来ます。<br><br>
<a href="<c:url value="/logout"/>">ログアウト</a>
</body>
</html>