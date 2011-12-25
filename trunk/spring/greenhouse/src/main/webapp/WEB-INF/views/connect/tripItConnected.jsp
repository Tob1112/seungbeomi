<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<c:if test="${not empty message}">
<div class="${message.type.cssClass}">${message.text}</div>
</c:if>

<form id="disconnect" action="<c:url value="/connect/tripit"/>" method="post">
	<div class="formInfo">
		<p>
			Your Greenhouse account is connected to your TripIt account.
			Click the button if you wish to disconnect.
		</p>
	</div>
	<input type="submit" value="Disconnect" />
	<input type="hidden" name="_method" value="DELETE" />
</form>
