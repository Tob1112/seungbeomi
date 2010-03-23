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

package jp.terasoluna.thin.tutorial.web.logon.dto;

import jp.terasoluna.thin.tutorial.web.common.uvo.TutorialUVO;

/**
 * ログオン処理の出力クラス。
 *
 */
public class LogonOutput {

    /**
     * ログイン情報を保持するUserValueObject
     */
    private TutorialUVO uvo = null;

    /**
     * UserValueObjectを返却する。
     * @return UserValueObject
     */
    public TutorialUVO getUvo() {
        return uvo;
    }

    /**
     * UserValueObjectを設定する。
     * @param uvo UserValueObject
     */
    public void setUvo(TutorialUVO uvo) {
        this.uvo = uvo;
    }


}
