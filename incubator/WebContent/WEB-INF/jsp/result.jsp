<%@ include file="./taglibs.jsp" %>
<html>
<head>
	<title>insert title</title>
	<!--<link rel="stylesheet" type="text/css" href="css/global.css"></link>-->
	<script type="text/javascript" src="js/global.js"></script>
</head> 
<body>
	<h1>struts + spring + ibatis + hsqldb + displayTag by son</h1>
	<display:table name="flora" class="list" id="floraTable" pagesize="4" export="false" requestURI="flora.do"> 
		<display:column property="floraId" paramId="floraId" href="index.jsp" title="ID" sortable="true" />
		<display:column property="name" paramId="name" href="index.jsp" sortable="true" />
		<display:column property="email" paramId="email" href="index.jsp" sortable="false" />
	</display:table> 
	<script type="text/javascript">highlightTableRows("floraTable");</script>
</body>
</html>