<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts/common/taglibs.jsp"%>

<div>
  <spring:message var="title" code="error_resourcenotfound_title" />

  <util:panel id="title" title="${title}">
    <h2>${fn:escapeXml(title)}</h2>
    <p>
      <spring:message code="error_resourcenotfound_problemdescription" />
    </p>
    <c:if test="${not empty exception}">
      <p>
        <h4>
          <spring:message code="exception_details" />
        </h4>
        <spring:message var="message" code="exception_message" />
        <util:panel id="_message" title="${message}" openPane="false">
          <c:out value="${exception.localizedMessage}" />
        </util:panel>
        <spring:message var="stacktrace" code="exception_stacktrace" />
        <util:panel id="_exception" title="${stacktrace}" openPane="false">
          <c:forEach items="${exception.stackTrace}" var="trace">
            <c:out value="${trace}" />
            <br />
          </c:forEach>
        </util:panel>
      </p>
    </c:if>
  </util:panel>
</div>