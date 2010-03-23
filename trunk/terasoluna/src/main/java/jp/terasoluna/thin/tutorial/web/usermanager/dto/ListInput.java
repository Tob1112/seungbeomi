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

/**
 *
 * 一覧データ取得処理の入力クラス
 *
 */
public class ListInput {

    /**
     * 表示行数。
     */
    private String row = null;

    /**
     * 開始インデックス。
     */
    private String startIndex = null;

    /**
     * 表示行数を返却する。
     * @return 表示行数
     */
    public String getRow() {
        return row;
    }

    /**
     * 表示行数を設定する。
     * @param row 表示行数
     */
    public void setRow(String row) {
        this.row = row;
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
}
