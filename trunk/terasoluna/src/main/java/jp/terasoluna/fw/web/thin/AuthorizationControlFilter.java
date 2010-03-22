/*

 * Copyright (c) 2007 NTT DATA Corporation

 *

 * Licensed under the Apache License, Version 2.0 (the "License");

 * you may not use this file except in compliance with the License.

 * You may obtain a copy of the License at

 *

 *      http://www.apache.org/licenses/LICENSE-2.0

 *

 * Unless required by applicable law or agreed to in writing, software

 * distributed under the License is distributed on an "AS IS" BASIS,

 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

 * See the License for the specific language governing permissions and

 * limitations under the License.

 */



package jp.terasoluna.fw.web.thin;



import java.io.IOException;



import javax.servlet.FilterChain;

import javax.servlet.FilterConfig;

import javax.servlet.ServletException;

import javax.servlet.ServletRequest;

import javax.servlet.ServletResponse;



import jp.terasoluna.fw.web.RequestUtil;



import org.apache.commons.logging.Log;

import org.apache.commons.logging.LogFactory;



/**

 * アクセス権限のチェックを行う。

 *

 * <p>

 * このクラスではブラウザからのリクエストに対するフィルタ処理を、

 * Bean定義ファイルで指定された任意の{@link AuthorizationController}インスタンス

 * を呼び出し、指定されたパスへのアクセス権限を持っているかどうかの

 * チェック処理を委譲する。

 * </p>

 *

 * <h5>アクセス権限チェック機能</h5>

 * <p>

 * 指定されたパスへのアクセス権限を持っているかを判別する。

 * アクセス権限違反の場合は、{@link UnauthorizedException}をスローする。

 * </p>

 * <h5>使用方法</h5>

 * <p>

 * この機能を使用するには デプロイメントディスクリプタ（web.xml）と

 * Bean定義ファイルに以下のように設定する。

 * このとき、Bean定義ファイルに定義するid属性が、

 * sampleAuthorizationControllerである&lt;bean&gt;要素の

 * class属性には、{@link AuthorizationController}インタフェースを

 * 実装したクラスを設定する。<br>

 *</p>

 * デプロイメントディスクリプタ（web.xml）<pre><code>

 * &lt;filter&gt;

 *   &lt;filter-name&gt;

 *     authorizationControlFilter

 *   &lt;/filter-name&gt;

 *   &lt;filter-class&gt;

 *     jp.terasoluna.fw.web.thin.AuthorizationControlFilter

 *   &lt;/filter-class&gt;

 *   &lt;init-param&gt;

 *     &lt;param-name&gt;controller&lt;/param-name&gt;

 *     &lt;param-value&gt;

 *       "sampleAuthorizationController"

 *     &lt;/param-value&gt;

 *   &lt;/init-param&gt;

 * &lt;/filter&gt;

 *

 * &lt;filter-mapping&gt;

 *   &lt;filter-name&gt;authorizationControlFilter&lt;/filter-name&gt;

 *   &lt;url-pattern&gt;/*&lt;/url-pattern&gt;

 * &lt;/filter-mapping&gt;

 *

 * &lt;error-page&gt;

 *   &lt;exception-type&gt;

 *     jp.terasoluna.fw.web.thin.UnauthorizedException

 *   &lt;/exception-type&gt;

 *   &lt;location&gt;/unauthorizedError.jsp&lt;/location&gt;

 * &lt;/error-page&gt;

 * </pre></code>

 *

 * Bean定義ファイル

 * <pre><code>

 * &lt;bean id=&quot;sampleAuthorizationController&quot;

 *       class=&quot;jp.terasoluna…SampleAuthorizationController&quot; /&gt;

 * </code></pre>

 *

 * なお、Bean定義ファイルに定義する&lt;bean&gt;要素のid属性をデフォルト値である

 * "authorizationController"に設定する場合には、

 * デプロイメントディスクリプタ（web.xml）内の&lt;filter&gt;要素から

 * &lt;init-param&gt;要素を省略することができる。

 *

 * @see jp.terasoluna.fw.web.thin.AuthorizationController

 * @see jp.terasoluna.fw.web.thin.BlockageControlFilter

 * @see jp.terasoluna.fw.web.thin.BlockageController

 * @see jp.terasoluna.fw.web.thin.ServerBlockageControlFilter

 * @see jp.terasoluna.fw.web.thin.ServerBlockageController

 *

 */

public class AuthorizationControlFilter

        extends AbstractControlFilter<AuthorizationController> {



    /**

     * リクエストがフィルタを通過したことを示すリクエスト属性のキー。

     */

    public static final String AUTHORIZATION_THRU_KEY

        = "AUTHORIZATION_THRU_KEY";



    /**

     * DIコンテナからコントローラーの実装クラスを取得するための

     * &lt;bean&gt;要素のid属性に使用されるデフォルトid。

     */

    public static final String DEFAULT_AUTHORIZATION_BEAN_ID

        = "authorizationController";



    /**

     * オーソリゼーションコントローラの生成失敗を示すエラーコード。

     */

    private static final String AUTHORIZATION_CONTROLLER_ERROR

        = "errors.authorization.controller";



    /**

     * アクセス権限チェック処理を委譲するコントローラクラス。

     */

    private static final Class AUTHORIZATION_CONTROLLER_CLASS

        = AuthorizationController.class;



    /**

     * ログクラス。

     */

    private static Log log

       = LogFactory

           .getLog(AuthorizationControlFilter.class);



    /**

     * AuthorizationControllerインスタンス。

     */

    protected static AuthorizationController controller = null;





    /**

     * AuthorizationControllerインスタンスを戻す。

     *

     * @return このフィルタに設定されているAuthorizationControllerインスタンス

     */

    public static AuthorizationController getAuthorizationController() {

        return controller;

    }



    /**

     * フィルタがサービス開始状態になる際に、コンテナによって呼び出される。

     *

     * コンテナは、Filterをインスタンス化した後に、initメソッドを

     * 1 回だけ呼び出す。<br>

     * Filterにフィルタ処理作業を実行するように要求するには、

     * init メソッドが正常に 終了していなければならない。

     * initメソッドが 次のいずれかの状態の場合、コンテナは

     * Filterをサービス状態にできない。<br>

     * <ul>

     *  <li>ServletException をスローした。</li>

     *  <li>コンテナによって定義された時間内に、復帰しない。</li>

     *  <li>設定されたコントローラの実装クラスが存在しない、

     *      または設定異常時。</li>

     * </ul>

     *

     * @param config FilterConfigインスタンス。

     *

     * @throws javax.servlet.ServletException 初期化異常時にスローされる例外。

     *

     * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)

     * @see jp.terasoluna.fw.web.thin.AbstractControlFilter

     */

    @Override

    public void init(FilterConfig config) throws ServletException {

        super.init(config);

        if (controller == null) {

            controller = getController();

        }

    }



    /**

     * アクセス権限チェックを行う。

     *

     * @param req HTTPリクエスト

     * @param res HTTPレスポンス

     * @param chain フィルタチェーン

     *

     * @throws IOException I/Oエラー

     * @throws ServletException サーブレット例外

     *

     * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,

     *                                    javax.servlet.ServletResponse,

     *                                    javax.servlet.FilterChain)

     */

    @Override

    public void doFilter(ServletRequest req,

                         ServletResponse res,

                         FilterChain chain)

            throws IOException,

                   ServletException {



        // リクエストがフィルタを通過したかどうかを判定。

        if (req.getAttribute(AUTHORIZATION_THRU_KEY) == null) {



            // フィルタの通過情報をセット

            req.setAttribute(AUTHORIZATION_THRU_KEY, "true");



            // 別業務に移ったかどうかパスチェックをする。

            if (controller.isCheckRequired(req)) {



                // アクセス権限チェック

                if (!controller

                    .isAuthorized(RequestUtil.getPathInfo(req), req)) {

                    if (log.isDebugEnabled()) {

                        log.debug("isAuthorized() failed.");

                    }

                    throw new UnauthorizedException();

                }

            }

        }



        // 次のフィルタまたはサーブレットへ

        chain.doFilter(req, res);

    }



    /**

     * アクセス制御を行うクラスが実装すべきインタフェースを返す。

     *

     * @return このフィルタで使用するコントローラのクラス

     */

    @Override

    protected Class getControllerClass() {

        return AUTHORIZATION_CONTROLLER_CLASS;

    }



    /**

     * コントローラの生成失敗を示すエラーコードを返す。

     *

     * @return エラーコード

     */

    @Override

    protected String getErrorCode() {

        return AUTHORIZATION_CONTROLLER_ERROR;

    }



    /**

     * DIコンテナからコントローラを取得する際のデフォルトのidを返す。

     *

     * @return デフォルトのid属性値

     */

    @Override

    public String getDefaultControllerBeanId() {

        return DEFAULT_AUTHORIZATION_BEAN_ID;

    }



}

