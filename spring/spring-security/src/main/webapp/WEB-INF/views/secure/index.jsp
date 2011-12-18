<%@ page language="java" contentType="text/html; charset=UTF-" pageEncoding="Windows-31J"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>SpringSecurity Sample</title></head>
<body>
ログインした権限に応じて、コンテンツを表示します。<br/>
  <security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER">
    <a href="<c:url value="/jsp/menu.jsp"/>">一般ユーザーコンテンツ</a><br/>
  </security:authorize>
  <security:authorize ifAllGranted="ROLE_ADMIN">
    <a href="<c:url value="/jsp/admin.jsp"/>">管理者コンテンツ</a><br/>
  </security:authorize>
</body>
</html>