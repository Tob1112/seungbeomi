<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts/common/taglibs.jsp"%>

<div>
  <h1>uncaughtException</h1>
  <div>
      <util:panel id="_message" title="${message}" openPane="false">
          <c:out value="${exception.localizedMessage}" />
    </util:panel>
    <util:panel id="_exception" title="${stacktrace}" openPane="false">
          <c:forEach items="${exception.stackTrace}" var="trace">
            <c:out value="${trace}" />
            <br />
          </c:forEach>
    </util:panel>
  </div>
</div>