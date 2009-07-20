<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ attribute name="path" required="true" %>

<spring:bind path="${path}">
	<font color="red"><c:out value="${status.errorMessage}" /></font>
</spring:bind>