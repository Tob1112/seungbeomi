<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>SpringSecurity Sample</title></head>
<body>
管理者コンテンツ<br><br>
このページは、管理者権限があるユーザーのみ閲覧することが出来ます。<br><br>
<a href="<c:url value="/logout"/>">ログアウト</a>
</body>
</html>