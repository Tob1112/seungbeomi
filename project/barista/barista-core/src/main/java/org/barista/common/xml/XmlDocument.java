package org.barista.common.xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.io.FileUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.ProcessingInstruction;
import org.xml.sax.InputSource;

import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;


/**
 * XML Document
 * <p>
 * 文字列としてあらわされたXMLやXMLファイルをDOM化し、タグや属性の値をXPathで参照できるようにします。ネームスペースには対応していません。
 * </p>
 * @author seungbeomi
 */
public class XmlDocument {

	/** 改行コード */
	private static final String CR_LF = "¥r¥n";
	/** このXMLドキュメントの元になるDOM */
	private Document source = null;
	/** XML処理命令 */
	private XmlProcessingInstruction xmlProcessingInstruction;


	/**
	 * コンストラクタです。
	 * <p>
	 * 指定されたXMLファイルからDOMを生成し、内部で保持します。
	 * </p>
	 * @param file XMLファイル
	 */
	public XmlDocument(File file) {
		String line;
		String xml;
		StringBuffer sb;
		BufferedReader br;

		sb = new StringBuffer();

		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
			while((line = br.readLine()) != null) {
				sb.append(line);
				sb.append(CR_LF);
			}
			br.close();

			xml = sb.toString();

			this.init(xml);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * コンストラクタです。
	 * <p>
	 * 指定されたXMLを表す文字列からDOMを生成し、内部で保持します。
	 * </p>
	 * @param xml XMLを表す文字列
	 */
	public XmlDocument(String xml) {
		this.init(xml);
	}

	/**
	 * コンストラクタです。
	 * <p>
	 * 指定されたDOMを内部で保持します。
	 * </p>
	 * @param source DOM
	 */
	public XmlDocument(Document source) {
		this.source = source;
	}

	/**
	 * 指定されたXMLを表す文字列からDOMを生成し、内部で保持します。
	 * @param xml XMLを表す文字列
	 */
	private void init(String xml) {
		Document source = null;
		DocumentBuilderFactory domFactory = null;
		DocumentBuilder domBuilder = null;
		SAXParserFactory saxFactory = null;
		SAXParser saxParser = null;
		XmlDocumentSaxHandler handler = null;
		ProcessingInstruction pi = null;

		try {
			domFactory = DocumentBuilderFactory.newInstance();
			domBuilder = domFactory.newDocumentBuilder();
			saxFactory = SAXParserFactory.newInstance();
			saxParser = saxFactory.newSAXParser();
			handler = new XmlDocumentSaxHandler();

			switch (xml.charAt(0)) {
			case 0xFEFF:
			case 0xFFFE:
			case 0xEFBB:
				xml = xml.substring(1);
				break;
			}

			//XMLを表す文字列をSAXでパース
			source = domBuilder.newDocument();
			handler.setDocument(source);
			//saxParser.parse(xml, handler);
			//saxParser.parse(new InputSource(xml), handler);
			saxParser.parse(new InputSource(new StringReader(xml)), handler);
			this.source = handler.getDocument();

			if ((handler.getXmlProcessingInstructionList() != null)
					&& (handler.getXmlProcessingInstructionList().size() > 0)) {
				this.xmlProcessingInstruction = handler.getXmlProcessingInstructionList().get(0);
				pi = this.source.createProcessingInstruction("xml-stylesheet", "type=\"text/xsl\" href=\"" + this.getStylesheetName() + "\"");
				this.source.insertBefore(pi, this.source).getChildNodes().item(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 指定されたXPathに相当するタグの値を取得する。
	 * <p>
	 * XPathに相当するタグがない場合、nullを返します。
	 * </p>
	 * @param xPath タグの値を取得するためのXPath
	 * @return タグの値
	 */
	public String getTagValue(String xPath) {
		return this.getNodeValue(xPath, Node.ELEMENT_NODE);
	}

	/**
	 * 指定されたXPathに相当する属性の値を取得する。
	 * <p>
	 * XPathに相当する属性がない場合、nullを返します。
	 * </p>
	 * @param xPath 属性の値を取得するためのXPath
	 * @return 属性の値
	 */
	public String getAttributeValue(String xPath) {
		return this.getNodeValue(xPath, Node.ATTRIBUTE_NODE);
	}

	/**
	 * 指定されたXPathに相当するタグの数を取得する。
	 * @param xPath タグの数を取得するためのXPath
	 * @return タグの数
	 */
	public final int getLength(String xPath) {
		int length = 0;
		NodeList nodes = null;

		//XPathを適用してノードを取得
		nodes = this.applyXPath(xPath);
		if (nodes != null) {
			length = nodes.getLength();
		} else {
			length = 0;
		}
		return length;
	}

	/**
	 * 指定されたXPath、ノードの種類に相当するノードの値を取得したす。
	 * <p>
	 * XPath、ノードの種類に相当するノードがない場合、nullを返します。
	 * </p>
	 * @param xPath ノードを取得するためのXPath
	 * @param nodeType ノードの種類
	 * @return ノードの値
	 */
	private String getNodeValue(String xPath, short nodeType) {
		NodeList nodes = null;
		String nodeValue = null;

		nodes = this.applyXPath(xPath);

		if (nodes != null) {
			//ノードが１つだけあり、かつ指定されたノード種類(タグまたは属性)の場合
			if((nodes.getLength() == 1) && (nodes.item(0).getNodeType() == nodeType)) {
				//テキストノードの値を取得
				//nodeValue = nodes.item(0).getTextContent();
				for (int i=0; i < nodes.getLength(); i++) {
					Node node = nodes.item(i);
					nodeValue = node.getNodeValue();
				}
			} else if (nodes.getLength() > 1) {
				throw new RuntimeException();
			}
		}
		return nodeValue;
	}

	/**
	 *指定されたXPathに相当するノードのリストを取得します。
	 * @param xPath ノードのリストを取得するためのXPath
	 * @return ノードのリスト
	 */
	private NodeList applyXPath(String xPath) {
		NodeList results = null;
		XPathFactory factory = null;
		XPath xp = null;
		XPathExpression expression = null;
		Node root = null;

		// XPathを生成　==========================================
		factory = XPathFactory.newInstance();
		xp = factory.newXPath();
		try {
			expression = xp.compile(xPath);
		} catch (XPathExpressionException e) {
			e.printStackTrace();
		}

		// XPathをDocumentに適用　=================================
		root = this.source.getDocumentElement();
		if (root != null) {
			try {
				results = (NodeList) expression.evaluate(root, XPathConstants.NODESET);
			} catch (XPathExpressionException e) {
				e.printStackTrace();
			}
		}
		return results;
	}

	@Override
	public String toString() {
		String formatted;
		StringWriter writer;
		OutputFormat of;
		XMLSerializer serializer;

		formatted = null;

		try {
			of = new OutputFormat(this.source);
			of.setIndenting(true);
			of.setLineSeparator(CR_LF);
			writer = new StringWriter();
			serializer = new XMLSerializer(writer, of);
			serializer.serialize(this.source);
			formatted = writer.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return formatted;
	}


	/**
	 * XMLドキュメントをファイルに出力する。
	 * @param outputPath 出力ファイルパス
	 * @throws IOException ファイルの書き込みに失敗した場合
	 */
	public void toFile(String outputPath) throws IOException {
		toFile(new File(outputPath));
	}

	/**
	 * XMLドキュメントをファイルに出力します。
	 * @param outputFile 出力ファイルパス
	 * @throws IOException ファイルの書き込みに失敗した場合
	 */
	private void toFile(File outputFile) throws IOException{
		FileUtils.writeStringToFile(outputFile, toString());
	}

	/**
	 * 内部で保持しているDOMを取得します。
	 * @return DOM
	 */
	public Document getSource() {
		return this.source;
	}

	/**
	 * スタイルシート名を取得します。
	 * @return　スタイルシート名
	 */
	private String getStylesheetName() {
		String stylesheetName;
		String target;
		String data;
		int indexOfStylesheetName;
		int indexOfDoubleQuote;

		stylesheetName = null;

		if (this.xmlProcessingInstruction != null) {
			target = xmlProcessingInstruction.getTarget();
			data = xmlProcessingInstruction.getData();

			if ((target != null) && target.equals("xml-stylesheet")) {
				if ((data != null) && data.contains("href=\"")) {
					indexOfStylesheetName = data.indexOf("href=\"") + "href=\"".length();
					stylesheetName = data.substring(indexOfStylesheetName);
					indexOfDoubleQuote = stylesheetName.indexOf("\"");
					if (indexOfDoubleQuote >= 0) {
						stylesheetName = stylesheetName.substring(0, indexOfDoubleQuote);
					}
				}
			}
		}
		return stylesheetName;
	}
}
