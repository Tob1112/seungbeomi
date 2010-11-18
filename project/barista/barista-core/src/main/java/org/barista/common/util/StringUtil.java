package org.barista.common.util;

public class StringUtil {

	public static String paddingLeft(String s, int length, char c) {
		StringBuffer buffer = new StringBuffer();

		if (s == null) {
			for (int i=0; i < length; i++) {
				buffer.append(c);
			}
		} else {
			if (s.length() > length) {
				buffer.append(s.substring(0, length));
			} else {
				for (int i=0, max = length - s.length(); i< max; i++) {
					buffer.append(c);
				}
				buffer.append(s);
			}
		}
		return buffer.toString();
	}
}
