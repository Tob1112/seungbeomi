package com.prms.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Converter {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	public static Object convert(Class type, Object value) {
		if (value == null) {
			return null;
		} else if (type == String.class) {
			return convertToString(type, value);
		} else if (type == Double.class) {
			return convertToDouble(type, value);
		}

		return MessageUtil.getMessage("E", "0001");
	}

	public static Object convertToString(Class type, Object value) {
		return value.toString();
	}

	private static Object convertToDouble(Class type, Object value) {
		return (Double) value;
	}
}
