/*
 * Copyright (c) 2008 NTT DATA Corporation
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

package jp.terasoluna.fw.dao.event;

/**
 * <p>
 * 1�s�̃f�[�^���������邽�߂̃C���^�t�F�[�X�B
 * </p>
 *
 * <p>
 * QueryRowHandleDAO�̎����N���X����ASQL�̎��s���ʂ�1�s����
 * handleRow���\�b�h���Ă΂��B<br>
 * ���̍ہA�����ɂ�1�s���̃f�[�^���i�[���ꂽ�I�u�W�F�N�g���n�����B
 * <br>
 * QueryRowHandleDAO�̎����N���X���g�p�̍ۂɂ́A
 * �{�C���^�t�F�[�X�����������N���X���쐬����K�v������B
 * </p>
 *
 * @see jp.terasoluna.fw.dao.QueryRowHandleDAO
 */
public interface DataRowHandler {

    /**
     * 1�s���ɌĂ΂�郁�\�b�h
     *
     * @param valueObject 1�s�̃f�[�^
     */
    void handleRow(Object valueObject);
}
