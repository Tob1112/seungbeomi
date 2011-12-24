<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>		
&copy; Copyright 2010-2011 SpringSource, a division of VMware
<aside id="site-switcher">
	<p>Site: 
		<c:if test="${currentSitePreference.mobile}">
			<a href="?site_preference=normal">Normal</a> | Mobile
		</c:if>
		<c:if test="${!currentSitePreference.mobile}">Normal | 
			<a href="?site_preference=mobile">Mobile</a>
		</c:if>
	</p>
</aside>