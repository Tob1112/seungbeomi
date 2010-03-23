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

package jp.terasoluna.thin.tutorial.web.usermanager.form;

import java.util.List;
import jp.terasoluna.fw.web.struts.form.ValidatorActionFormEx;
import jp.terasoluna.thin.tutorial.web.usermanager.vo.SelectUserOutput;

/**
 * ユーザー管理業務で使用するアクションフォーム。
 *
 */
public class UserManagerForm extends ValidatorActionFormEx {

    /**
     * シリアルバージョンID。
     */
    private static final long serialVersionUID = 1L;

    /*登録画面で使用する*/
    /**
     * ユーザID。
     */
    private Long id = null;

    /**
     * ユーザ名。
     */
    private String name = null;

    /**
     * 年齢。
     */
    private String age = null;

    /**
     * 生年月日。
     */
    private String birth = null;

    /*一覧画面で使用する*/

    /**
     * 表示行数。
     */
    private String row = "10";

    /**
     * 開始インデックス。
     */
    private String startIndex ="0";

    /**
     * 全件数。
     */
    private String totalCount = null;

    /**
     * 表示用ユーザリスト。
     */
    private List<SelectUserOutput> users = null;

    /**
     * ユーザIDを返却する。
     *
     * @return 保持するユーザID
     */
    public Long getId() {
        return id;
    }

    /**
     * ユーザIDを設定する。
     *
     * @param id ユーザID
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * ユーザ名を返却する。
     *
     * @return 保持するユーザ名
     */
    public String getName() {
        return name;
    }

    /**
     * ユーザ名を設定する。
     *
     * @param name ユーザ名
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 年齢を返却する。
     *
     * @return 保持する年齢
     */
    public String getAge() {
        return age;
    }

    /**
     * 年齢を設定する。
     *
     * @param age 年齢
     */
    public void setAge(String age) {
        this.age = age;
    }

    /**
     * 生年月日を返却する。
     *
     * @return 保持する生年月日
     */
    public String getBirth() {
        return birth;
    }

    /**
     * 生年月日を設定する。
     *
     * @param birth 生年月日
     */
    public void setBirth(String birth) {
        this.birth = birth;
    }

    /**
     * 表示行数を返却する。
     * @return 表示行数
     */
    public String getRow() {
        return row;
    }

    /**
     * 開始インデックスを返却する。
     * @return 開始インデックス
     */
    public String getStartIndex() {
        return startIndex;
    }

    /**
     * 開始インデックスを設定する。
     * @param startIndex 開始インデックス
     */
    public void setStartIndex(String startIndex) {
        this.startIndex = startIndex;
    }

    /**
     * 全件数を返却する。
     * @return 全件数
     */
    public String getTotalCount() {
        return totalCount;
    }

    /**
     * 全件数を返却する。
     * @param totalCount 全件数
     */
    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }

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
}
