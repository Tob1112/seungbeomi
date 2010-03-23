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

package jp.terasoluna.thin.tutorial.web.logon.form;

import jp.terasoluna.fw.web.struts.form.ValidatorActionFormEx;

/**
 * ログオン業務で使用するアクションフォーム。
 *
 */
public class LogonForm extends ValidatorActionFormEx {

    /**
     * シリアルバージョンID。
     */
    private static final long serialVersionUID = 1L;

    /**
     * ユーザID。
     */
    private String userId = null;

    /**
     * ユーザIDを返却する。
     *
     * @return ユーザID
     */
    public String getUserId() {
        return userId;
    }

    /**
     * ユーザIDを設定する。
     *
     * @param userId ユーザID
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

}
