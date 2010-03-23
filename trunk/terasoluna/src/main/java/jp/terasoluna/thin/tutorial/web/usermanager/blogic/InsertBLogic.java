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

package jp.terasoluna.thin.tutorial.web.usermanager.blogic;

import jp.terasoluna.fw.dao.QueryDAO;
import jp.terasoluna.fw.dao.UpdateDAO;
import jp.terasoluna.fw.service.thin.BLogic;
import jp.terasoluna.fw.service.thin.BLogicMessage;
import jp.terasoluna.fw.service.thin.BLogicMessages;
import jp.terasoluna.fw.service.thin.BLogicResult;
import jp.terasoluna.thin.tutorial.web.usermanager.dto.InsertInput;
import jp.terasoluna.thin.tutorial.web.usermanager.vo.SelectUserOutput;

/**
 * 登録処理を行うビジネスロジック。
 *
 */
public class InsertBLogic implements BLogic<InsertInput> {

    /**
     * QueryDAO。
     * Springによりインスタンス生成され設定される。
     */
    private QueryDAO queryDAO = null;

    /**
     * UpdateDAO。
     * Springによりインスタンス生成され設定される。
     */
    private UpdateDAO updateDAO = null;

    /**
     * 登録処理を行う。
     */
    public BLogicResult execute(InsertInput param) {
        BLogicResult result = new BLogicResult();

        SelectUserOutput selectUserOutput
            = queryDAO.executeForObject("getUser", param, SelectUserOutput.class);

        //登録するIDが重複してる場合は異常処理をする
        if(selectUserOutput != null) {

            //エラーメッセージ処理
            BLogicMessages messages = new BLogicMessages();
            messages.add("message",
                    new BLogicMessage("errors.input.id.repeat"));
            result.setErrors(messages);

            result.setResultString("failure");
            return result;
        }

        //登録処理
        updateDAO.execute("insertUser", param);

        //メッセージ処理
        BLogicMessages messages = new BLogicMessages();
        messages.add("message",
                new BLogicMessage("message.regist",param.getId()));
        result.setMessages(messages);
        result.setResultString("success");

        return result;

        //業務例外をスローする
        //throw new InsertException();
    }

    /**
     * QueryDAOを設定する。
     * @param queryDAO
     */
    public void setQueryDAO(QueryDAO queryDAO) {
        this.queryDAO = queryDAO;
    }

    /**
     * UpdateDAOを設定する。
     * @param updateDAO
     */
    public void setUpdateDAO(UpdateDAO updateDAO) {
        this.updateDAO = updateDAO;
    }

}
