<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<html>
<head>
<title><fmt:message key="index.title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0
	marginwidth=0 marginheight=0>
<div id="welcome">
<h1>시스템 에러가 발생했습니다.</h1>

<p><span class="drop">자</span>바지기가 쓴 Spring Framework Workbook의 샘플 예제에
오신 것을 환영합니다. 요청한 페이지 내부에서 에러가 발생했습니다. 에러 메세지는 다음과 같습니다.</p>
<br/>
<p><span class="fieldError"><c:out value="${sampleException.message}"/></span></p>
</div>
</body>
</html>
