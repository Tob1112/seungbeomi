<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>ログイン画面</title></head>
<body>
  <form name="f" action="<c:url value='j_spring_security_check'/>" method="post">
    ID：<input type="text" name="j_username"/><br/>
    パスワード：<input type="password" name="j_password"/><br/>
    <input type="submit"/>
  </form>
</body>
</html>