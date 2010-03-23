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

package jp.terasoluna.fw.transaction.util;

import org.springframework.transaction.interceptor.TransactionAspectSupport;

/**
 * �g�����U�N�V�����֘A�̃��[�e�B���e�B�N���X�B
 * <h4>�y�N���X�̊T�v�z</h4>
 * ��O�𔭐��������Ƃ����[���o�b�N�����s���邳���Ɏg�p����TransactionUtil�N���X�B<br>
 * setRollbackOnly���\�b�h�g�p����isRollbackOnly�X�e�[�^�X��true�ɕύX����B
 * <p>
 */
public class TransactionUtil {

    /**
     * ���[���o�b�N���s�̃t���O�𗧂Ă�B
     * 
     * <p>
     * �Ɩ������ł̃g�����U�N�V���������ɂ����āA��O�𔭐��������Ƃ�if��
     * �̏�������Ȃǂɂ���ă��[���o�b�N�����s���邽�߂̃t���O��ݒ肷��B
     * </p>
     */
    public static void setRollbackOnly() {

        // RollbackOnly�̃t���O��true�ɐݒ肷��B
        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();

    }
}
