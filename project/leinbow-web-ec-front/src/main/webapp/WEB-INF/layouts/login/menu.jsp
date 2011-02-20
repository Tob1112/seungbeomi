<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <!-- header領域 [s] -->


<div class="region" id="header">
    <div id="viewStatus">
        <p>&nbsp;</p>
    </div>

    <div class="areaGroup">
        <div class="area-siteId-01">
            <p id="siteId-01"><a href="/" shape="rect"><img width="314" height="51" alt="RESTIR.COM" src="/g_images/siteid-01.gif"></a></p>
        <!-- area-siteId-01 --></div>

        <div class="area-users-01">
            <form action="/index.html" enctype="application/x-www-form-urlencoded" method="post" name="layoutHeadershop:header2Form" id="header2Form">
                <input type="submit" style="display: none;" value="ログアウト" name="layoutHeadershop:header2Form:doLogout-h" id="doLogout-h">
                <input type="hidden" value="rO0ABXQAEDk0Nzc5NTA5MjAxNTMwNTk=" name="sessionTime">
                <input type="hidden" value="layoutHeadershop:header2Form" name="layoutHeadershop:header2Form/view/front/index.html">
            </form>

            <div class="block-navigation-01">
                <ul>
                    <span id="isJpFlg-2">
                    <li><a href="/login/" shape="rect">LOGIN</a></li>
                    <li><a href="/interim/" shape="rect">SIGN UP</a></li>
                    </span>
                </ul>
            <!-- / block-navigation-01 --></div>


            <div class="block-search-01" id="retrieval">
                <form action="/index.html" enctype="application/x-www-form-urlencoded" method="post" name="layoutHeadershop:searchForm" id="searchForm">
                    <input type="text" style="display: none;" value="Keyword" name="layoutHeadershop:searchForm:search-1" id="search-1">
                    <input type="text" onkeypress="return submitSearch('doGoodsSearch',event);" style="color: rgb(153, 153, 153); width: 153px;" maxlength="100" value="Keyword" name="layoutHeadershop:searchForm:search" id="search">
                    <input type="image" onmouseover="this.src='../images/button/btn-item-search2.png'" onmouseout="this.src='../images/button/btn-item-search.png'" src="/images/button/btn-item-search.png" name="layoutHeadershop:searchForm:doGoodsSearch" id="doGoodsSearch">
                    <input type="hidden" value="rO0ABXQAEDk0Nzc5NTA5MjAxNTMwNTk=" name="sessionTime">
                    <input type="hidden" value="layoutHeadershop:searchForm" name="layoutHeadershop:searchForm/view/front/index.html">
                </form>
            </div>

            <div class="block-langswitcn-01">
                <p class="switch"><a href="javascript:void(0);" shape="rect" onclick="switchLanguage();"><span id="language">JAPANESE</span>&nbsp;⁄&nbsp;<span id="currency">￥</span>&nbsp;&nbsp;<img width="4" height="7" alt=" " src="/g_images/icn-arrow-10.gif"></a></p>
            <!-- / block-langswitcn-01 --></div>

            <div class="block-cart-01" id="cart-A">
                <ul><li><a href="#" shape="rect"><img width="90" height="20" class="rollover" alt="CART" src="/images/button/btn-cart-01.gif"></a>
                <div style="overflow: hidden; height: 0px; min-width: 90px; position: absolute; right: 0px; width: 190px;">
                    <div class="subBlock" style="display: block; position: static; visibility: visible;">
                    <dl><dt>QUANTITY</dt><dd>0</dd><dt>TOTAL PRICES</dt><dd>￥0</dd></dl>
                    <p><a href="./../cart/index.html" shape="rect"><span>GO TO CART</span></a></p>
                    </div>
                </div>
                </li></ul>
            <!-- / block-cart-01 --></div>
        <!-- area-users-01 --></div>

<div id="globalNavigation-01" class="area-globalNavigation-01">




<ul class="logout"><li><a shape="rect" href="/"><img height="23" alt="home" width="52" class="rollover" src="/g_images/txt-home-01.gif" /></a></li><li><span id="isJpFlg-7"><a shape="rect" href="/store/store.html"><img src="/g_images/txt-shop-01.gif" height="23" alt="e-shop" width="64" class="rollover" /></a></span></li><li><a shape="rect" href="/magazine/"><img src="/g_images/txt-magazine-01.gif" height="23" alt="magazine" width="86" class="rollover" /></a></li><li><a shape="rect" href="/news/"><img src="/g_images/txt-news-01.gif" height="23" alt="news" width="48" class="rollover" /></a></li><li><a shape="rect" href="/blog/"><img src="/g_images/txt-blog-01.gif" height="23" alt="blog" width="41" class="rollover" /></a></li><li><a shape="rect" href="/videos/"><img src="/g_images/txt-videos-01.gif" height="23" alt="videos" width="60" class="rollover" /></a></li><li><a shape="rect" href="/music/"><img src="/g_images/txt-music-01.gif" height="23" alt="music" width="55" class="rollover" /></a></li></ul>


<!-- / area-globalNavigation-01 --></div>

<div id="categoryNavigation-A" class="area-categoryNavigation-01">

<!-- / categoryNavigation-01 --></div>
<!-- / areaGroup --></div>
<!-- / header --></div>
