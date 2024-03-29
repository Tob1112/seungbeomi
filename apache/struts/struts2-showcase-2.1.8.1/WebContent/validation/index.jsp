<%--
    index.jsp

    @author tm_jee
    @version $Date: 2007-07-10 15:48:47 -0400 (Tue, 10 Jul 2007) $ $Id: index.jsp 555058 2007-07-10 19:48:47Z musachy $
--%>

<%@taglib prefix="s" uri="/struts-tags" %>

<html>
    <head>
        <title>Showcase - Validation</title>
    </head>
    <body>
        <h1>Validation Examples</h1>
        
        <s:url var="quizBasic" namespace="/validation" action="quizBasic" method="input"/>
        <s:url var="quizClient" namespace="/validation" action="quizClient" method="input"/>
        <s:url var="quizClientCss" namespace="/validation" action="quizClientCss" method="input"/>
        <s:url var="quizAjax" namespace="/validation" action="quizAjax" method="input"/>
        <s:url var="fieldValidatorUrl" action="showFieldValidatorsExamples" namespace="/validation" />
        <s:url var="nonFieldValidatorUrl" action="showNonFieldValidatorsExamples" namespace="/validation" />
        <s:url var="visitorValidatorUrl" action="showVisitorValidatorsExamples" namespace="/validation" />
        <s:url var="clientSideValidationUrl" action="clientSideValidationExample" namespace="/validation" />
        <s:url var="backToShowcase" action="showcase" namespace="/" />
        <s:url var="storeMessageAcrossRequestExample" value="/validation/storeErrorsAcrossRequestExample.jsp" />
        
        <ul>
            <li><s:a href="%{fieldValidatorUrl}">Field Validators</s:a></li>
            <li><s:a href="%{clientSideValidationUrl}">Field Validators with client-side JavaScript</s:a></li>
            <li><s:a href="%{nonFieldValidatorUrl}">Non Field Validator</s:a></li>
            <li><s:a href="%{storeMessageAcrossRequestExample}">Store across request using MessageStoreInterceptor (Example)</s:a></li>
            <li><s:a href="%{quizAjax}">Validation (ajax)</s:a></li>
            <li><s:a href="%{quizBasic}">Validation (basic)</s:a></li>
            <li><s:a href="%{quizClient}">Validation (client)</s:a></li>
            <li><s:a href="%{quizClientCss}">Validation (client using css_xhtml theme)</s:a></li>
            <li><s:a href="%{visitorValidatorUrl}">Visitor Validator</s:a></li>
            <li><s:a href="%{backToShowcase}">Back To Showcase</s:a>
        </ul>
    </body>
</html>

