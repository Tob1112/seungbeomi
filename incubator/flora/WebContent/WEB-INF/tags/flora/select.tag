<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ attribute name="path" required="true" %>
<%@ attribute name="size" required="true" %>
<%@ attribute name="cssClass" required="false" %>
<%@ attribute name="items" required="true" %>
<%@ attribute name="var" required="true" %>
<%@ attribute name="value" required="true" %>

<spring:bind path="${path}">
	<select class="${cssClass}" size="${size}"
		name="<c:out value='${status.expression}' />">
		<c:forEach items="${items}" var="${var}">
			<option value="<c:out value='${value}' />">
				<c:out value="${value}" />
			</option>		
		</c:forEach>
	</select>
</spring:bind>
