<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts/common/taglibs.jsp" %>


<div style="width: 960px; margin: 0pt auto; border-top: 6px solid rgb(0, 0, 0);">
    <div id="restir_topMusic_jasrac">
        <p>JASRAC No. 9012338001Y31015 / 9012338002Y45038</p>
    </div>
</div>



<div class="region" id="footer">
    <span id="isJpFlg">
    <div class="area-utility-01">
    <ul id="company-navi"><li class="first"><a href="/" shape="rect">Home</a></li><li><a href="/aboutus/midtown.html" shape="rect">Restir Boutique</a></li><li><a href="/aboutus/" shape="rect">The company's</a></li><li><a href="/aboutus/contact.html" shape="rect">Contact</a></li><li><a href="/guide/index.html" shape="rect">Shopping guide</a></li><li><a href="/aboutus/privacy.html" shape="rect">Privacy policy</a></li><li><a href="/aboutus/regal.html" shape="rect">特定商取引法</a></li><li><a href="/aboutus/terms.html" shape="rect">利用規約</a></li></ul>
    </div>
    </span>
    <span id="language">
        <c:out value=" | "/>
        <spring:message code="global_language"/>
        <c:out value=": "/>
        <util:language label="English" locale="en"/>
        <util:language label="Japaness" locale="ja"/>
        <util:language label="Korean" locale="ko"/>
    </span>

    <util:theme/>

    <div class="area-address-01">
        <address>Restir Inc. all rights reserved.</address>
    <!-- / area-address-01 --></div>
<!-- / footer --></div>




<%--
<!-- Google Analytics Code -->
 --%>


<!--  RESTIR footer END -->

