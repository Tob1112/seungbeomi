package org.barista.common.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.barista.exception.BaristaRuntimeException;
import org.barista.common.message.BaristaMessages;
import org.barista.common.message.MessageId;

public class StringDigester {

	private static final String ZERO = "0";

	public static enum Algorithm {
		SHA1("SHA-1"),
		SHA256("SHA-256"),
		MD5("MD5");

		private String symbol;

		Algorithm(String symbol) {
			this.symbol = symbol;
		}

		@Override
		public String toString() {
			return this.symbol;
		}
	}

	public static String digest(Algorithm algorithm, String digestable) {
		String messageId;
		String message;
		String digested = null;
		String hexed;
		StringBuilder sb;
		byte[] digestableBytes;
		byte[] digestedBytes;
		int lengthOfDigestedBytes;
		MessageDigest md;

		try {
			digestableBytes = digestable.getBytes();

			md = MessageDigest.getInstance(algorithm.toString());
			md.update(digestableBytes, 0, digestableBytes.length);
			digestedBytes = md.digest();

			sb = new StringBuilder();

			lengthOfDigestedBytes = digestedBytes.length;
			for (int i=0; i< lengthOfDigestedBytes; i++) {
				hexed = Integer.toHexString(digestedBytes[i] & 0xff);
				if (hexed.length() == 1) {
					sb.append(ZERO);
				}
				sb.append(hexed);
			}
			digested = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			messageId = MessageId.ALGORITHM_NOT_SUPPORTED;
			message = BaristaMessages.getMessage(messageId);
			throw new BaristaRuntimeException(messageId, message, e);
		}
		return digested;

	}


}
