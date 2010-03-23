<%@ page contentType="text/html; charset=Windows-31J"%>
<%@ taglib uri="/struts-html" prefix="html" %>
<%@ taglib uri="/struts-bean" prefix="bean" %>
<%@ taglib uri="/struts-logic" prefix="logic" %>
<%@ taglib uri="/terasoluna-struts" prefix="ts" %>
<%@ taglib uri="/terasoluna" prefix="t" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_jis">
<title>ログオン画面</title>
</head>

<body>
<table border="0" style="width:100%;">
    <tr>
        <td align="center">
            <html:img module="/" page="/image/terasoluna_logo.gif" />
        </td>
    </tr>
    <tr>
        <td align="center">
            <h2>
                ログオン画面
            </h2>
        </td>
    </tr>
</table>

<html:errors />
<ts:form action="/logon/logonBL">
<table border="0" align="center">
  <tr>
    <td>
      UserId：
    </td>
    <td>
      <html:text property="userId"/>
    </td>
    <td>
      <ts:submit value="ログオン"/>
    </td>
  </tr>
</table>
</ts:form>
</body>
</html:html>