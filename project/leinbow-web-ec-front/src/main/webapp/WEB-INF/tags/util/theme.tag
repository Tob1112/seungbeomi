<%@ tag pageEncoding="utf-8" %>

<%-- jstl --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- spring --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<%@ attribute name="render" type="java.lang.Boolean" required="false" description="Indicate if the contents of this tag and all enclosed tags should be rendered (default 'true')" %>

  <c:if test="${empty render or render}">
    <span>
      <c:out value=" | " />
      <spring:message code="global_theme" />
      <c:out value=": " />
      <spring:url var="url_theme1" value="">
        <spring:param name="theme" value="standard" />
        <c:if test="${not empty param.page}">
          <spring:param name="page" value="${param.page}" />
        </c:if>
        <c:if test="${not empty param.size}">
          <spring:param name="size" value="${param.size}" />
        </c:if>
      </spring:url>
      <spring:message code="global_theme_standard" var="theme_standard" />
      <a href="${url_theme1}" title="${theme_standard}">${theme_standard}</a>
      <c:out value=" | " />
      <spring:url var="url_theme2" value="">
        <spring:param name="theme" value="alt" />
        <c:if test="${not empty param.page}">
          <spring:param name="page" value="${param.page}" />
        </c:if>
        <c:if test="${not empty param.size}">
          <spring:param name="size" value="${param.size}" />
        </c:if>
      </spring:url>
      <spring:message code="global_theme_alt" var="theme_alt" />
      <a href="${url_theme2}" title="${theme_alt}">${theme_alt}</a>
    </span>
  </c:if>
