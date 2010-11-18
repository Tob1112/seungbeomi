package org.barista.common.xml;

import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

/**
 * XMLドキュメントが文字列として表すXMLをDOM化するときに利用するSAXハンドラです。
 */
public class XmlDocumentSaxHandler extends DefaultHandler{
	/** ドキュメントです。 */
	private Document document = null;
	/** 現在のノードです。 */
	private Node currentNode = null;
	/** XML処理命令のリストです。 */
	private List<XmlProcessingInstruction> xmlProcessingInstructions
		= new ArrayList<XmlProcessingInstruction>();

	public void setDocument(Document document) {
		this.document = document;
	}
	public Document getDocument() {
		return this.document;
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) {
		Node childNode = null;
		Attr attribute = null;
		int sizeOfAttributes = 0;

		// 新しいノードを生成します。
		childNode = document.createElement(qName);

		sizeOfAttributes = attributes.getLength();
		for (int i = 0; i < sizeOfAttributes; i++) {
			//新しい属性を生成し、新しいノードに追加
			attribute = document.createAttribute(attributes.getQName(i));
			attribute.setNodeValue(attributes.getValue(i));
			((Element) childNode).setAttributeNode(attribute);
		}

		if (currentNode != null) {
			//現在のノードに新しいノード追加
			currentNode.appendChild(childNode);
		} else {
			//DOMに新しいノードを追加
			document.appendChild(childNode);
		}
		//新しいノードを現在のノードとする。
		currentNode = childNode;
	}

	@Override
	public void characters(char[] ch, int start, int length) {
		currentNode.appendChild(document.createTextNode(new String(ch, start, length)));
	}

	@Override
	public void endElement(String uri, String localName, String qName) {
		currentNode = currentNode.getParentNode();
	}

	public List<XmlProcessingInstruction> getXmlProcessingInstructionList() {
		return this.xmlProcessingInstructions;
	}

}
