package com.prms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.prms.exception.PrmsException;

/**
 * パスワード暗号化処理クラス
 *
 * @author 孫承範
 */
public class Md5Encrypt {

	private final static Logger logger = LoggerFactory.getLogger(Md5Encrypt.class);

	/**
	 * 暗号化処理メソッド
	 *
	 * @param password パスワード
	 * @return md5で暗号化された文字列
	 */
	public static String encryptingPassword(String password) {
		StringBuilder stringBuilder = new StringBuilder();

		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(password.getBytes());
			byte[] md5encrypt = md5.digest();

			for (int i = 0; i < md5encrypt.length; i++) {
				stringBuilder.append(Integer
						.toHexString((int) md5encrypt[i] & 0xFF));
			}

		} catch (NoSuchAlgorithmException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		}

		return new String(stringBuilder);
	}
}
