package seungbeomi.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Encrypt {

	public String encrypting(String password) {

		StringBuilder stringBuilder = new StringBuilder();

		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(password.getBytes());
			byte[] md5encrypt = md5.digest();

			for (int i=0; i < md5encrypt.length; i++) {
				stringBuilder.append(Integer.toHexString((int)md5encrypt[i] & 0xFF));
			}

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return new String(stringBuilder);
	}

}
