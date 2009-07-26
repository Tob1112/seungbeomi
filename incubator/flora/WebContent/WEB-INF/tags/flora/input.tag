<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ attribute name="path" required="true" %>
<%@ attribute name="type" required="true" %>
<%@ attribute name="cssClass" required="false" %>

<spring:bind path="${path}">
	<input type="${type}" class="${cssClass}" 
		name="<c:out value='${status.expression}' />"
		value="<c:out value='${status.value}' />"
		maxlength="20">
		<font color="red">
			<c:out value="${status.errorMessage}" />
		</font>			   
</spring:bind>
