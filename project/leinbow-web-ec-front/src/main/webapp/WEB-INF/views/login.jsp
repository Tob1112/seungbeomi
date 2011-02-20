<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts/common/taglibs.jsp"%>


        <div class="bar-message bar-color02" id="isAllMessage">
            <div class="inner">
                <strong>
                    <ul id="allMessages">
                    <c:if test="${not empty loginInfo}">
                    <spring:bind path="loginInfo">
                        <c:forEach items="${status.errorMessages}" var="error">
                        <li><span omittag="true">${error}</span></li>
                        </c:forEach>
                    </spring:bind>
                    </c:if>
                    </ul>
                </strong>
            </div>
        </div>



    <div id="main">
        <!-- col-all領域 [s] -->
        <div id="col-all">
        <h1 class="ttl02">Login</h1>

            <!-- boxx-login領域 [s] -->
            <div id="boxx-login" class="group">
                <!-- member-login領域 [s] -->
                <div id="member-login">
                    <h2 class="ttl06">Member login<span class="ttl06-jp">会員ログイン</span></h2>
                    <form name="loginInfo" action="/session" method="post">
                        <div id="member-login-in">
                            <p class="box01">ご登録のメールアドレス、パスワードを入力していただき、「LOGIN」ボタンをクリックしてください。</p>
                            <table class="tb-format">
                                <tr>
                                    <th colspan="2" class="cell-listmark" rowspan="1">メールアドレス</th>
                                    <td colspan="1" class="cell-subtitle-base" rowspan="1">
                                        <input id="j_username" type='text' name='j_username' value="${loginInfo.j_username}" class="tbox-m" title="メールアドレス" />&nbsp;[半角英数]
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2" class="cell-listmark" rowspan="1">パスワード</th>
                                    <td colspan="1" class="cell-subtitle-base" rowspan="1">
                                        <input id="j_password" type='password' name='j_password' class="tbox-m" title="パスワード" />&nbsp;[半角英数4～20文字以内]
                                    </td>
                                </tr>
                            </table>

                            <p class="box01">
                                <input type="checkbox" name="_spring_security_remember_me" />　次回からメールアドレスの入力を省略
                             </p>
                            <div id="btn-login" class="group">
                                <input type="submit" id="doLogin" name="memberForm:doLogin" title="ログイン" alt="ログイン" class="btn btn07 btn-left" />
                                <p class="link-icon"><a id="goPassWordResetMailPage" href="../reset/index.html" shape="rect">パスワードをお忘れの方はこちら</a></p>
                            </div>
                            <p class="box01">※ウィッシュリスト、ニュースレターなどのサービスをご利用いただくには、<br clear="none" />ご本人さま確認のためにログインが必要です。</p>
                        </div>
                    </form>
                </div>
                <!-- member-login領域 [e] -->

                <!-- select-login領域 [s] -->
                <div id="select-login">
                    <!-- new-login領域 [s] -->
                    <div id="new-login">
                        <h2 class="ttl06">Sign up<span class="ttl06-jp">新規会員登録</span></h2>
                        <div id="new-login-in">
                            <div class="text-login">本サイトでのご注文、ご利用には会員登録（無料）が必要です。お届け先がご登録できるほか、ニュースレターなどの特典がございます。会員登録をされる方は、「SIGN UP」ボタンをクリックして、会員登録画面にお進みください。
                            <p class="link-icon"><a shape="rect" href="/guide/member.html#01">会員について</a></p></div>
                            <p><a title="新規会員登録" class="btn btn08" shape="rect" href="../interim/index.html">新規会員登録</a></p>
                        </div>
                    </div>
                    <!-- new-login領域 [e] -->
                </div>
                <!-- select-login領域 [e] -->
            </div>
            <!-- boxx-login領域 [e] -->

            <div class="group box01">
                <h2 class="ttl06">Privilege of membership<span class="ttl06-jp">新規会員登録</span></h2>
                <div>
                    <h3><strong>"ONLINE SHOPPING"</strong></h3>
                    <p>お求めいただきました商品は￥5,000(税込）以上送料無料です。（￥5,000未満は￥525)また、返品・交換も承っております。<br clear="none" />
                    メンバー登録いただきますと、ONLINE SHOPPINGの際、毎回の住所入力等の必要はございません。ご希望の商品をスムーズにご購入いただけます。<br clear="none" />
                    また、会員様専用の「MY PAGE」内では、気になる商品をチェックしたり、購入履歴をご覧いただくことができます。</p>
                  </div>
                <div class="box01">
                    <h3><strong>"NEWS LETTER"</strong></h3>
                    <p>イベントのご案内やSALE情報、RESTIR .COMでしか手に入らないエクスルーシヴ商品のご紹介など<br clear="none" />様々な情報が満載の“RESTIR.COM NEWS LETTER”をお送りさせて頂きます。</p>
                </div>
                <div class="box01">
                    <h3><strong>"SECRET SALE"</strong></h3>
                    <p>会員様には一足早くRESTIR MIDTOWNのプレセールや、ご自宅にいながらお店同様の商品や雰囲気が体感できる、デジタルセールサイトへご招待させていただきます。</p>
                </div>
                <div class="box01">
                    <p>その他、会員様だけの特典をご用意して皆様のご登録をお待ちいたしております。<br clear="none" />GET YOUR COPY NOW!</p>
                </div>
            </div>
        </div>
        <!-- col-all領域 [e] -->
    </div>
    <!-- main領域 [e] -->