<%@ tag pageEncoding="utf-8" %>

<%-- jstl --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- spring --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- attribute --%>
<%@ attribute name="locale" type="java.lang.String" required="true" description="The locale for the language to be added." %>
<%@ attribute name="label" type="java.lang.String" required="true" description="The country label for the language to be added." %>
<%@ attribute name="render" type="java.lang.Boolean" required="false" description="Indicate if the contents of this tag and all enclosed tags should be rendered (default 'true')" %>



  <c:if test="${empty render or render}">
    <spring:url var="img" value="/resources/images/flag/${locale}.png" />
    <spring:url var="url" value="">
      <c:if test="${null ne param.form}">
        <spring:param name="form" />
      </c:if>
      <c:if test="${not empty param.find}">
        <spring:param name="find" value="${param.find}" />
      </c:if>
      <spring:param name="lang" value="${locale}" />
      <c:if test="${not empty param.page}">
        <spring:param name="page" value="${param.page}" />
      </c:if>
      <c:if test="${not empty param.size}">
        <spring:param name="size" value="${param.size}" />
      </c:if>
    </spring:url>
    <spring:message code="global_language_switch" arguments="${label}" var="lang_label" />
    <a href="${fn:escapeXml(url)}" title="${fn:escapeXml(lang_label)}">
      <img class="flag" src="${fn:escapeXml(img)}" alt="${fn:escapeXml(lang_label)}" />
    </a>
    <c:out value=" " />
  </c:if>
