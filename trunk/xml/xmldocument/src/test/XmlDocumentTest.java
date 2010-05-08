package test;

import static org.junit.Assert.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.junit.Test;

import xml.XmlDocument;


public class XmlDocumentTest {

	private static final String XPATH_BOOKLIST = "/book";
	private static final String XPATH_BOOK_TITLE = "";
	private static final String XPATH_BOOK_AUTHOR = "";
	private static final String XPATH_BOOK_PUBLISHER = "";
	private static final String XPATH_BOOK_PRICE = "";

	private static final String CR_LF = "¥r¥n";

	@Test
	public void testXmlDocuemt() {
		int sizeOfBookList;

		XmlDocument xmlDoc = this.loadXmlDocument("./src/test/test.xml");

		//sizeOfBookList = xmlDoc.getLength(XPATH_BOOKLIST);
		//System.out.println(sizeOfBookList);

	}

	private XmlDocument loadXmlDocument(String file) {
		String line;
		String xml;
		StringBuffer sb;
		BufferedReader br;
		XmlDocument loaded;

		sb = new StringBuffer();

		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
			while ((line = br.readLine()) != null) {
				sb.append(line);
				sb.append(CR_LF);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		xml = sb.toString();
		loaded = new XmlDocument(xml);

		return loaded;
	}

}
