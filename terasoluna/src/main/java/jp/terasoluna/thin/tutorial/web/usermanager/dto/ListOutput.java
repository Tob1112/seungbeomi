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

package jp.terasoluna.thin.tutorial.web.usermanager.dto;

import java.util.List;

import jp.terasoluna.thin.tutorial.web.usermanager.vo.SelectUserOutput;

/**
 *
 * 一覧データ取得処理の出力クラス
 *
 */
public class ListOutput {

    /**
     * 表示用ユーザリスト。
     */
    private List<SelectUserOutput> users = null;

    /**
     * ユーザリストの全件数。
     */
    private String totalCount;

    /**
     * 表示用ユーザリストを返却する。
     * @return 表示用ユーザリスト
     */
    public List<SelectUserOutput> getUsers() {
        return users;
    }

    /**
     * 表示用ユーザリストを設定する。
     * @param users 表示用ユーザリスト
     */
    public void setUsers(List<SelectUserOutput> users) {
        this.users = users;
    }

    /**
     * ユーザリストの全件数を返却する。
     * @return ユーザリストの全件数
     */
    public String getTotalCount() {
        return totalCount;
    }

    /**
     * ユーザリストの全件数を設定する。
     * @param totalCount ユーザリストの全件数
     */
    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }
}
