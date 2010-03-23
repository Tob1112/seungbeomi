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

package jp.terasoluna.fw.web.rich.springmvc.bind.creator.exception;

/**
 * バインド例外クラス
 *
 * <p>
 * リクエストストリームの読み込みに失敗した場合に、本例外がスローされる。
 * </p>
 *
 */
public class XMLRequestIOException extends RuntimeException {
    /**
     * シリアルバージョンID。
     */
    private static final long serialVersionUID = -3630321738490293561L;

    /**
     * コンストラクタ
     *
     * @param cause 例外
     */
    public XMLRequestIOException(Throwable cause) {
        super(cause);
    }
}
