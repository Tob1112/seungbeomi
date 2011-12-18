<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>SpringSecurity Sample</title></head>
<body>
<security:authorize ifAnyGranted="ROLE_USER">
	<p>
		Welcome, <Strong><security:authentication property="principal.username" /></Strong>
	</p>
</security:authorize>
ログインした権限に応じて、コンテンツを表示します。<br/>
  <security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER">
    <a href="<c:url value="/secure/menu.do"/>">一般ユーザーコンテンツ</a><br/>
  </security:authorize>
  <security:authorize ifAllGranted="ROLE_ADMIN">
    <a href="<c:url value="/secure/admin.do"/>">管理者コンテンツ</a><br/>
  </security:authorize>
  
<p>
	<a href="<c:url value="/secure/changePassword.do"/>" >Change Password</a>
</p>
</body>
</html>