<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts/common/taglibs.jsp"%>

<html>
    <head>
        <tiles:insertAttribute name="header" ignore="true" />
    </head>
    <body>
        <tiles:insertAttribute name="menu" ignore="true" />
        <tiles:insertAttribute name="body"/>
        <tiles:insertAttribute name="footer" ignore="true"/>
    </body>
</html>
