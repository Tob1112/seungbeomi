<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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

        <div class="area-globalNavigation-01" id="globalNavigation-01">
            <ul class="logout"><li><a href="/" shape="rect"><img width="52" height="23" src="/g_images/txt-home-01.gif" class="rollover" alt="home"></a></li><li><span id="isJpFlg-7"><a href="/store/store.html" shape="rect"><img width="64" height="23" class="rollover" alt="e-shop" src="/g_images/txt-shop-01.gif"></a></span></li><li><a href="/magazine/" shape="rect"><img width="86" height="23" class="rollover" alt="magazine" src="/g_images/txt-magazine-01.gif"></a></li><li><a href="/news/" shape="rect"><img width="48" height="23" class="rollover" alt="news" src="/g_images/txt-news-01.gif"></a></li><li><a href="/blog/" shape="rect"><img width="41" height="23" class="rollover" alt="blog" src="/g_images/txt-blog-01.gif"></a></li><li><a href="/videos/" shape="rect"><img width="60" height="23" class="rollover" alt="videos" src="/g_images/txt-videos-01.gif"></a></li><li><a href="/music/" shape="rect"><img width="55" height="23" class="rollover" alt="music" src="/g_images/txt-music-01.gif"></a></li></ul>
        <!-- / area-globalNavigation-01 --></div>

<div><img src="/g_images/blackline-01.PNG"></div>
<div id="categoryNavigation-A" class="area-categoryNavigation-01">
<span class="e-SHOP"><a href="/store/store.html"><img src="/g_images/eshop.gif" alt="e-SHOP"></a></span>
<ul style="visibility: visible;">
<li><a href="#" class="sale" style="margin-top: -10px; padding: 0px 13px;"><div style="font-size: 10px; font-family: Helvetica,Arial,sans-serif; font-weight: normal;">2010AW</div><div style="margin-top: -2px;">SALE</div></a>
<div style="overflow: hidden; height: 0px; min-width: 70px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=02000016">WOMENS</a>
</li>
<li><a href="/goods/list.html?cid=02000028">MENS</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">NEW</a>
<div style="overflow: hidden; height: 0px; min-width: 66px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=70100000">WOMENS NEW</a>
</li>
<li><a href="/goods/list.html?cid=70200000">MENS NEW</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">BRANDS</a>
<div style="overflow: hidden; height: 0px; min-width: 96px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/brands.html?cid=30100000">WOMENS</a>
</li>
<li><a href="/goods/brands.html?cid=30200000">MENS</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">WOMENS</a>
<div style="overflow: hidden; height: 0px; min-width: 105px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=10000001">ALL</a>
</li>
<li><a href="/goods/list.html?cid=10100001">TOPS</a>
</li>
<li><a href="/goods/list.html?cid=10900001">ACCESSORIES / JEWELRY</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">MENS</a>
<div style="overflow: hidden; height: 0px; min-width: 75px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=20000001">ALL</a>
</li>
<li><a href="/goods/list.html?cid=20100001">TOPS</a>
</li>
<li><a href="/goods/list.html?cid=20800001">BELTS</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">CULTURE</a>
<div style="overflow: hidden; height: 0px; min-width: 108px; position: absolute;">
    <div class="subBlock-A" style="display: block; position: static; visibility: visible;">
        <ul>
            <li><a href="/goods/list.html?cid=40300000">ALL</a></li>
            <li><a href="/goods/list.html?cid=40100001">BOOKS</a></li>
        </ul>
    </div>
</div>
</li>
<li><a href="#" style="padding: 0px 13px;">BEAUTY</a>
<div style="overflow: hidden; height: 0px; min-width: 96px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=50600000">ALL</a>
</li>
<li><a href="/goods/list.html?cid=50400001">COSMETICS</a>
</li>
</ul>
</div></div>
</li>
<li><a href="#" style="padding: 0px 13px;">DIGITAL</a>
<div style="overflow: hidden; height: 0px; min-width: 97px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul>
<li><a href="/goods/list.html?cid=60400000">ALL</a>
</li>
<li><a href="/goods/list.html?cid=60100001">TECHNOLOGY</a>
</li>
<li><a href="/goods/list.html?cid=60200001">ACCESSORIES</a>
</li>
<li><a href="/goods/list.html?cid=60300001">CAMERAS</a>
</li>
</ul>
</div></div>
</li>


<li class="gift"><a href="#" shape="rect" style="padding: 0px 13px;">GIFT</a>
<div style="overflow: hidden; height: 0px; min-width: 67px; position: absolute;"><div class="subBlock-A" style="display: block; position: static; visibility: visible;">
<ul><li class="giftAll"><a href="/goods/list.html?cid=01000000" shape="rect"></a></li><li class="giftAll"><a href="/gift/all.html?cid=01100001" shape="rect"></a></li><li><a href="/gift/womens.html?cid=01100002" shape="rect">FOR HER</a></li><li><a href="/gift/mens.html?cid=01100003" shape="rect">FOR HIM</a></li></ul>
</div></div>
</li>



</ul>
<div style="clear: both;"><img src="/g_images/blackline-02.PNG"></div>
</div>


<!-- / areaGroup --></div>
<!-- / header --></div>
