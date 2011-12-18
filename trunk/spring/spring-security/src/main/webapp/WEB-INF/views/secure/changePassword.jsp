<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>SpringSecurity Sample</title></head>
<body>
<h1>Change Password</h1>
	<form method="post">
		<label for="password">New Password</label>
		<input id="password" name="password" size="20" maxlength="50" type="password"/>
		<br/>
		<input type="submit" value="Change Password">	
	</form>
</body>
</html>