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

package jp.terasoluna.thin.tutorial.web.logon.blogic;

import jp.terasoluna.fw.service.thin.BLogic;
import jp.terasoluna.fw.service.thin.BLogicResult;
import jp.terasoluna.fw.web.UserValueObject;
import jp.terasoluna.thin.tutorial.web.common.uvo.TutorialUVO;
import jp.terasoluna.thin.tutorial.web.logon.dto.LogonInput;
import jp.terasoluna.thin.tutorial.web.logon.dto.LogonOutput;

/**
 * ログオン処理を行うビジネスロジック。
 *
 */
public class LogonBLogic implements BLogic<LogonInput> {

    /**
     * ログオン処理を行う。
     *
     * @param param 入力されたユーザIDを保持したMap
     * @return BLogicResult ログオン処理結果を保持したBLogicResult
     */
    public BLogicResult execute(LogonInput param) {

        //入力されたユーザIDの取得
        String userId = param.getUserId();

        //UVOの生成
        TutorialUVO uvo = (TutorialUVO) UserValueObject.createUserValueObject();

        //ユーザIDをUVOに設定する。
        uvo.setUserId(userId);

        //UVOを返却用のクラスに設定する。
        LogonOutput output = new LogonOutput();
        output.setUvo(uvo);

        //BLogicResultの生成、設定
        BLogicResult result = new BLogicResult();
        result.setResultObject(output);
        result.setResultString("success");

        return result;
    }

}
