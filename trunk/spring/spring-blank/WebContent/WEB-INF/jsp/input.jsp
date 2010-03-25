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
  <form:form action="validate.do" method="POST">
	<spring:hasBindErrors name="command"/>
    <!-- 必須チェックを行う -->
    名前　：　<input type="text" name="name" />
    <font color="red"><form:errors path="name"/></font>
    <br/>

    <!-- 桁数チェックを行う -->
    数字　：　<input type="text" name="number" />
    <font color="red"><form:errors path="number"/></font>
    <br/>

    <!-- 日付フォーマット変換 -->
    日付　：　<input type="text" name="date"
    />
    <font color="red"><form:errors path="date"/></font>
    <br/>

    <input type="submit" />
  </form:form>
</body>
</html>