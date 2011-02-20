<div xmlns:spring="http://www.springframework.org/tags" xmlns:fn="http://java.sun.com/jsp/jstl/functions" xmlns:util="urn:jsptagdir:/WEB-INF/tags/util" xmlns:c="http://java.sun.com/jsp/jstl/core" xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0">
    <h1>test user list</h1>

    <jsp:output omit-xml-declaration="yes" />
    <c:forEach items="${list}" var="user">
        <c:out value="${user.id}" /> : <c:out value="${user.name}" /><br />
    </c:forEach>

</div>