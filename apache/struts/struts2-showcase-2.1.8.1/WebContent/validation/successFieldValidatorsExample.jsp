<%--
    successFieldValidatorsExample.jsp
    
    @author tm_jee
    @version $Date: 2006-09-06 00:07:10 -0400 (Wed, 06 Sep 2006) $ $Id: successFieldValidatorsExample.jsp 440609 2006-09-06 04:07:10Z wsmoak $
--%>

<%@taglib prefix="s" uri="/struts-tags" %>

<html>
    <head><title>Showcase - Validation - SuccessFieldValidatorsExample</title></head>
    <body>
        <h1>Success !</h1>
        <table>
            <tr>
                <td>Required Validator Field:</td>
                <td><s:property value="requiredValidatorField" /></td>
            </tr>
            <tr>
                <td>Required String Validator Field:</td>
                <td><s:property value="requiredStringValidatorField" /></td>
            </tr>
            <tr>
                <td>Integer Validator Field: </td>
                <td><s:property value="integerValidatorField" /></td>
            </tr>
            <tr>
                <td>Date Validator Field: </td>
                <td><s:property value="dateValidatorField" /></td>
            </tr>
            <tr>
                <td>Email Validator Field: </td>
                <td><s:property value="emailValidatorField" /></td>
            </tr>
            <tr>
                <td>String Length Validator Field: </td>
                <td><s:property value="stringLengthValidatorField" /></td>
            </tr>
            <tr>
                <td>Regex Validator Field: <s:property value="regexValidatorField" /></td>
                <td>Field Expression Validator Field: <s:property value="fieldExpressionValidatorField" /></td>
            </tr>
        </table>
        
        <s:include value="footer.jsp" />
    </body>
</html>

