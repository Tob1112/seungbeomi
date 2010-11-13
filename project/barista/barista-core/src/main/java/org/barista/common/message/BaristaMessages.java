package org.barista.common.message;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.barista.common.xml.XmlDocument;
import org.barista.exception.BaristaRuntimeException;

public final class BaristaMessages extends Properties {

	private static final String CONFIG_FILE_NAME = "message.xml";
	private static final String SEQUENCE_NO = "n";
	private static final String REPLACABLE = "{$" + SEQUENCE_NO + "}";
	private static final String CR_LF = "\r\n";
	private static final String EMPTY = "";
	private static final String SPACE = " ";
	private static final String BASE_INDENT = "	";
	private static final int MAX_INDENT_LEVEL = 10;
	private static final String MESSAGE_ID_FILE_NOT_FOUND = "BA90001";
	private static final String MESSAGE_ID_IO_ERROR = "BA90002";
	private static final String MESSAGE_FILE_NOT_FOUND = "MESSAGE FILE NOT FOUND fileName=<" + CONFIG_FILE_NAME + ">";
	private static final String MESSAGE_IO_ERROR = "MESSAGE IO ERROR";
	private static BaristaMessages messages = new BaristaMessages();
	private static List<String> indents;

	private BaristaMessages() {
		String line;
		String xml;
		String fileName;
		String messageId;
		String message;
		String indent;
		StringBuffer sb;
		int numberOfFiles;
		Properties properties;
		Set<Object> keySet;
		Iterator<Object> iterator;
		ClassLoader cl;
		InputStream is;
		BufferedReader br;
		XmlDocument config;
		InputStreamReader in = null;

		try {
			properties = new Properties();
			cl = Thread.currentThread().getContextClassLoader();
			sb = new StringBuffer();
			in = new InputStreamReader(cl.getResourceAsStream(CONFIG_FILE_NAME));
			br = new BufferedReader(in);
			while ((line = br.readLine()) != null) {
				sb.append(line);
				sb.append(CR_LF);
			}
			xml = sb.toString();
			config = new XmlDocument(xml);

			numberOfFiles = config.getLength("/message/file");
			for (int i=0; i < numberOfFiles; i++) {
				fileName = config.getAttributeValue("/message/file[" + (i + 1) + "]/@name");
				is = cl.getResourceAsStream(fileName);
				if (is == null) {
					throw new BaristaRuntimeException(MESSAGE_ID_FILE_NOT_FOUND, MESSAGE_FILE_NOT_FOUND);
				}
				properties.clear();
				properties.load(is);
				is.close();

				keySet = properties.keySet();
				iterator =  keySet.iterator();
				while (iterator.hasNext()) {
					messageId = (String) iterator.next();
					message = properties.getProperty(messageId);

					this.put(messageId, message);
				}
			}
		} catch (IOException e) {
			throw new BaristaRuntimeException(MESSAGE_ID_IO_ERROR, MESSAGE_ID_IO_ERROR);
		} finally {
			try {
				if (in != null) in.close();
			} catch (IOException e) {
				throw new BaristaRuntimeException(MESSAGE_ID_IO_ERROR, MESSAGE_ID_IO_ERROR);
			}
		}

		indents = new ArrayList<String>();
		indent = EMPTY;

		for (int i=0; i < MAX_INDENT_LEVEL; i++) {
			indents.add(indent);
			indent += BASE_INDENT;
		}
	}

	public static String getMessage(String messageId) {
		return messages.getProperty(messageId);
	}

	public static String getMessage(String messageId, String[] replacements) {
		String message;
		String replaceable;

		message = getMessage(messageId);

		if (replacements != null) {
			for (int i=0; i < replacements.length; i++) {
				replaceable = REPLACABLE.replace(SEQUENCE_NO, Integer.toString(i));
				replacements[i] = (replacements[i] == null) ? EMPTY : replacements[i];
				if (message != null) {
					message = message.replace(replaceable, replacements[i]);
				}
			}
		}
		return message;
	}

	public static String getMessage(String messageId, String[] replacements, int indentLevel) {
		String message;
		String indent;
		String combined;

		if ((replacements != null) && (replacements.length > 0)) {
			message = getMessage(messageId, replacements);
		} else {
			message = getMessage(messageId);
		}
		indent = (indentLevel < MAX_INDENT_LEVEL) ? indents.get(indentLevel) : indents.get(MAX_INDENT_LEVEL - 1);
		combined = messageId + SPACE + indent + message;

		return combined;
	}

	public static String getMessage(String messageId, int indentLevel) {
		return getMessage(messageId, null, indentLevel);
	}


}
