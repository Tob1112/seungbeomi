<%@page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<html>
<head>
<title><decorator:title default="Mysterious page..." /></title>
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/global.css" rel=stylesheet  type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/global.js"></script>
<decorator:head />
</head>
<body>
<table width="900" border="0" align="center">
	<tr>
	<td>
	<table width="100%" border="0">
		<tr>
			<td width="25%" align="left">
				<a href="http://www.javajigi.net" target="_blank">
					<img src="${pageContext.request.contextPath}/images/javajigi_logo.jpg" border="0" />
				</a>
			</td>
			<td align="right">
				<table bgcolor="#ffffff">
				<form method="get" action="http://www.google.com/custom" target="_blank">
				<tr><td nowrap="nowrap" valign="top" align="left" height="32">
				<a href="http://www.google.com/">
				<img src="http://www.google.com/logos/Logo_25wht.gif" border="0" alt="Google" align="middle"></img></a>
				<input type="text" name="q" size="31" maxlength="255" value=""></input>
				<input type="submit" name="sa" value="Search"></input>
				<input type="hidden" name="client" value="pub-0116131400397176"></input>
				<input type="hidden" name="forid" value="1"></input>
				<input type="hidden" name="ie" value="utf8"></input>
				<input type="hidden" name="oe" value="utf8"></input>
				<input type="hidden" name="cof" value="GALT:#008000;GL:1;DIV:#336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;FORID:1;"></input>
				<input type="hidden" name="hl" value="ko"></input>
				</td></tr>
				</form>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a href="${pageContext.request.contextPath}/changelocale.do?locale=1">
					<fmt:message key="locale.japan"/>
				</a>
				&nbsp;
				<a href="${pageContext.request.contextPath}/changelocale.do?locale=2">
					<fmt:message key="locale.english"/>
				</a>
			</td>
		</tr>
		<tr>
			<td valign="top" width="20%">
			<table width="100%" height="100%">
				<tr>
					<td valign="top" height="100%">
						<page:applyDecorator name="panel" page="/menu.do"  />

						<page:applyDecorator name="panel" page="/user/login.do"  />
					</td>
				</tr>
			</table>
			</td>
			<td>
			<table width="100%" height="100%">
				<tr>
					<td id="pageTitle"><decorator:title /></td>
				</tr>
				<tr>
					<td valign="top" height="100%"><decorator:body /></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="2">This site is a sample project of <b>Spring Framework
			Workbook</b><br />
			Site powered by a free <b>Open Source Project</b> of <a
				href="http://www.javajigi.net"><b>JavaJiGi<b /></a></td>
		</tr>
	</table>
	</td>
	</tr>
</table>
</body>
</html>
