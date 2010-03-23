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
<title>登録画面</title>
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
                登録画面
            </h2>
        </td>
    </tr>
</table>

<ts:form action="/userManager/insertBL">

<fieldset style="border:2pt solid black;padding:20px;width:100%;">
    <legend style="font-weight:bold;">
      登録情報入力
    </legend><p>
    <table border="0" frame="box">
        <tr>
            <td valign="top">
                <table frame="box">
                    <tr>
                        <td align="center" width="50">
                            ID
                        </td>
                        <td width="200">
                            <html:text name="_userManagerForm" property="id" maxlength="10" />
                            <br><span style="font-size:xx-small; color:red">(必須入力,数字のみ10桁以内))</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="50">
                            NAME
                        </td>
                        <td width="200">
                            <html:text name="_userManagerForm" property="name" maxlength="20" />
                            <br><span style="font-size:xx-small; color:red">(必須入力,20桁以内))</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="50">
                            AGE
                        </td>
                        <td width="200">
                            <html:text name="_userManagerForm" property="age" maxlength="3" />
                            <br><span style="font-size:xx-small; color:red">(必須入力,数字のみ3桁以内))</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="50">
                            BIRTH
                        </td>
                        <td width="200">
                            <html:text name="_userManagerForm" property="birth" maxlength="10" />
                            <br><span style="font-size:xx-small; color:red">(yyyy/MM/dd形式))</span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <ts:submit value="登録" />
            </td>
        </tr>
    </table>
</fieldset>

<hr>

<ts:link page="/logon/menuSCR.do">メニュー</ts:link>

</ts:form>
</body>
</html:html>
