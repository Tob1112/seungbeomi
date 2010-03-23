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

package jp.terasoluna.thin.tutorial.web.usermanager.vo;

import java.io.Serializable;

/**
 * ユーザ情報保持Bean。
 *
 * データベースからの取得時、画面からの入力時に使用される。
 *
 */
public class SelectUserOutput implements Serializable {

    /**
     * シリアルバージョンID。
     */
    private static final long serialVersionUID = 161610379384156463L;

    /**
     * ID。
     */
    private Long id = null;

    /**
     * 名前。
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

    /**
     * IDを返却する。
     *
     * @return 保持するID
     */
    public Long getId() {
        return id;
    }

    /**
     * IDを設定する。
     *
     * @param id ID
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 名前を返却する。
     *
     * @return 保持する名前
     */
    public String getName() {
        return name;
    }

    /**
     * 名前を設定する。
     *
     * @param name 名前
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
}
