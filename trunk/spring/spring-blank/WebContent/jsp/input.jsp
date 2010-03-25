<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Validate Sample</title>
</head>
<body>
  <form action="validate.do" method="POST">
	<spring:hasBindErrors name="command"/>
    <!-- 必須チェックを行う -->
    <form:errors path="command.name"/>
    名前　：　<input type="text" name="name"
    value="<c:out value="${status.value}"/>" />
    <font color="red"><c:out value="${status.errorMessage}" /></font>
    <br/>

    <!-- 桁数チェックを行う -->
    <form:errors path="command.number"/>
    数字　：　<input type="text" name="number"
    value="<c:out value="${status.value}"/>"/>
    <font color="red"><c:out value="${status.errorMessage}" /></font>
    <br/>

    <!-- 日付フォーマット変換 -->
    <form:errors path="command.date"/>
    日付　：　<input type="text" name="date"
    value="<c:out value="${status.value}"/>"/>
    <font color="red"><c:out value="${status.errorMessage}" /></font>
    <br/>

    <input type="submit" />
  </form>
</body>
</html>