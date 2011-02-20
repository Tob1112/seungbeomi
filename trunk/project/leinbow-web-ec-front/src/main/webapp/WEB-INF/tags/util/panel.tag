<%-- jstl --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- spring --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- attribute --%>
<%@ attribute name="id" type="java.lang.String" required="true" description="The identifier for this tag (do not change!)" %>
<%@ attribute name="title" type="java.lang.String" required="true" description="The page title (required)" %>
<%@ attribute name="render" type="java.lang.Boolean" required="false" description="Indicate if the contents of this tag and all enclosed tags should be rendered (default 'true')" %>
<%@ attribute name="z" type="java.lang.String" required="false" description="Used for checking if element has been modified (to recalculate simply provide empty string value)" %>
<%@ attribute name="openPane" type="java.lang.String" required="false" description="Control if the title pane is opened or closed by default (default: true)" %>

  <c:if test="${empty render or render}">
    <c:if test="${empty openPane}">
      <c:set value="true" var="openPane" />
    </c:if>

    <c:set var="sec_id">
      <spring:escapeBody javaScriptEscape="true" >${id}</spring:escapeBody>
    </c:set>

    <c:set var="sec_openPane">
      <spring:escapeBody javaScriptEscape="true" >${openPane}</spring:escapeBody>
    </c:set>

    <c:set var="sec_title">
      <spring:escapeBody javaScriptEscape="true" >${title}</spring:escapeBody>
    </c:set>

    <script type="text/javascript">dojo.require('dijit.TitlePane');</script>
    <div id="_title_${sec_id}_id">
      <script type="text/javascript">Spring.addDecoration(new Spring.ElementDecoration({elementId : '_title_${sec_id}_id', widgetType : 'dijit.TitlePane', widgetAttrs : {title: '${sec_title}', open: ${sec_openPane}}})); </script>
      <jsp:doBody />
    </div>
  </c:if>
