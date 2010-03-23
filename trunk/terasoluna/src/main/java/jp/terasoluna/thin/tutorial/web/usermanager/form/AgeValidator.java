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

import java.text.SimpleDateFormat;
import jp.terasoluna.fw.util.DateUtil;
import jp.terasoluna.fw.web.struts.form.MultiFieldValidator;

/**
 * 入力された年齢と、生年月日の相関入力チェックを行う。
 *
 */
public class AgeValidator implements MultiFieldValidator {

    /**
     * 入力された年齢と、生年月日の相関入力チェックを行う。
     *
     * @param birth 生年月日
     * @param fields 関連する入力フィールド値
     * @return チェック結果
     */
    public boolean validate(String birth, String[] fields) {
        String age = fields[0];

        if (birth == null || "".equals(birth)) {
            return true;
        }

        return checkBirthAndAge(birth, Integer.parseInt(age));
    }

    /**
     * 入力された生年月日から計算した年齢と入力された年齢を比較する。
     * 同一の場合はtrueを返却、異なっている場合は、falseを返却する。
     *
     * @param birth 入力された誕生日
     * @param age 入力された年齢
     * @return 比較結果
     */
    private boolean checkBirthAndAge(String birth, int age) {

        //現在日付の取得
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
        String temp = format.format(DateUtil.getSystemTime());

        //年月日を配列に変換。
        String[] old = birth.split("/");
        String[] now = temp.split("/");

        //単純に現在の年から、入力された年を引く。
        int minus = Integer.parseInt(now[0]) - Integer.parseInt(old[0]);

        //入力された月が現在の月以下の場合、且つ
        //入力された日が現在の日よりも小さい場合は、マイナス１する。
        if ((Integer.parseInt(now[1]) < Integer.parseInt(old[1]))
         || (Integer.parseInt(now[1]) == Integer.parseInt(old[1])
         && Integer.parseInt(now[2]) < Integer.parseInt(old[2]))) {
            minus--;
        }

        //入力された年齢と比較する。
        if (age == minus) {
            return true;
        }
        return false;
    }
}
