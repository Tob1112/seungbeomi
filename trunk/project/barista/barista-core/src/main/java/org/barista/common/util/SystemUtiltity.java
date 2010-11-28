package org.barista.common.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Logger;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.SystemUtils;
import org.barista.common.message.BaristaMessages;
import org.barista.common.message.MessageId;
import org.barista.exception.BaristaRuntimeException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public final class SystemUtiltity {

	private static final Logger log = Logger.getLogger(SystemUtiltity.class.getName());

	//private static final String TMPDIR_PROPERTIES_FILE_NAME = "tmpdir.properties";
	private static final String TMPDIR_PROPERTIES_FILE_NAME = "system.properties";
	private static final String TMP_DIR_APP = "tmpdir.app";
	private static final String TMPDIR_WINDOWS_KEY = "tmpdir.path.windows";
	private static final String TMPDIR_LINUX_KEY = "tmpdir.path.linux";
	private static final int GET_FILE_IN_JAR_BUFFER_SIZE = 1024;
	private static final int MAKE_TEMPDIR_RETRYING_FREQUENCY = 2;

	private static String tmpBaseDir;
	//private static SystemProperty sp = SystemPropertyImpl.getInstance();
	private static SystemUtiltity INSTANCE = new SystemUtiltity();

	/**
	 * OS의 종류에 따라서 임시디렉토리생성시의 기준디렉토리를 설정한다.
	 */
	private SystemUtiltity() {
		ClassLoader cl = null;
		InputStream is = null;
		Properties prop = new Properties();
		try {
			cl = Thread.currentThread().getContextClassLoader();
			is = cl.getResourceAsStream(TMPDIR_PROPERTIES_FILE_NAME);
			prop.load(is);
		} catch (FileNotFoundException e) {
			throw new BaristaRuntimeException(MessageId.FILE_NOT_FOUND,
					BaristaMessages.getMessage(MessageId.FILE_NOT_FOUND));
		} catch (IOException e) {
			throw new BaristaRuntimeException(MessageId.IO_EXCEPTION,
					BaristaMessages.getMessage(MessageId.IO_EXCEPTION));
		} finally {
			IOUtils.closeQuietly(is);
		}

		if (SystemUtils.IS_OS_WINDOWS) {
			tmpBaseDir = prop.getProperty(TMPDIR_WINDOWS_KEY);
		} else if (SystemUtils.IS_OS_LINUX || SystemUtils.IS_OS_MAC) {
			tmpBaseDir = prop.getProperty(TMPDIR_LINUX_KEY);
		} else {
			log.warning("OS가 WINDOWS, LINUX가 아닙니다.");
		}
	}

	/**
	 * 랜덤문자열을 취득한다.
	 * @return 랜덤문자열
	 */
	public static String getRandomString() {
		return UUID.randomUUID().toString();
	}

	/**
	 * 임시파일로서 사용할 파일을 생성해서 반환한다.<br>
	 * 생성장소는 시스템이 지정하는 일시영역이다.<br>
	 * 실재로 파일을 생성은 하지 않기때문에 실파일을 생성하고 싶은 경우에는 독자적으로 생성한다.
	 * @param extension 임시파일의 확장자
	 * @return 생성한 임시파일명
	 */
	public static File getTemporaryFile(String extension) {
		return getTemporaryFile("", extension);
	}

	/**
	 * 임시파일로서 사용할 파일을 생성해서 반환한다.<br>
	 * 임시파일을 생성한 디렉토리를 지정하고싶은 경우에 사용한다.<br>
	 * 시스템이 지정한 임시영역에 지정한 디렉토리에 생성하고, 그 디렉토리내에 임시파일을 생성한다.<br>
	 * 실재로 파일을 생성은 하지 않기때문에 실파일을 생성하고 싶은 경우에는 독자적으로 생성한다.
	 * @param dirName 임시파일을 생성한 패스
	 * @param extension 임시파일의 확장자
	 * @return 생성한 임시파일명
	 */
	public static File getTemporaryFile(String dirName, String extension) {
		if (extension.length() < 1) {
			throw new IllegalArgumentException("인수가 올바르지 않습니다.");
		}
		File tmpFile = null;
		if (StringUtils.isEmpty(dirName)) {
			tmpFile = new File(tmpBaseDir + File.separator
					+ getRandomString().concat("." + extension));
		} else {
			tmpFile = new File(tmpBaseDir + File.separator + dirName
					+ File.separator + getRandomString().concat("." + extension));
		}
		return tmpFile;
	}

	/**
	 * 임시파일로서 사용할 파일을 생성해서 반환한다.<br>
	 * 임시파일을 생성한 디렉토리를 지정하고싶은 경우에 사용한다.<br>
	 * FILE형식의 디렉토리밑에 생성한다. <br>
	 * 실재로 파일을 생성은 하지 않기때문에 실파일을 생성하고 싶은 경우에는 독자적으로 생성한다.
	 * @param dir 임시파일을 생성한 디렉토리
	 * @param extension 임시파일의 확장자
	 * @return 생성한 임시파일명
	 */
	public static File getTemporaryFile(File dir, String extension) {
		File tmpFile = null;
		if (dir.isDirectory() && dir.getPath().length() >0 && extension.length() > 0) {
			tmpFile = new File(dir.getPath() + File.separator +  getRandomString().concat("." + extension));
		} else {
			throw new IllegalArgumentException("인수가 올바르지 않습니다.");
		}
		return tmpFile;
	}

	/**
	 * 임시디렉토리를 취득한다. (서브디렉토리명을 지정안함) <br>
	 * 기준디렉토리에 임시 디렉토리를 생성하고 반환한다.<br>
	 * "/기준디렉토리/랜덤문자열의디렉토리" <br>
	 * 실재디렉토리를 생성하지 않기 때문에 실재디렉토리를 생성할경우엔 File.mkdirs()들을 사용하여 생성한다.
	 * @return 임시디레토리
	 */
	public static File getTemporaryDirectory() {
		return getTemporaryDirectory(null);
	}

	/**
	 * 임시디렉토리를 취득한다. (서브디렉토리명을 지정) <br>
	 * 기준디렉토리밑에 지정된 서브드렉토리 그 밑에 임시디렉토리로 한다.<br>
	 * "/기준디렉토리/지정디렉토리/랜덤문자열의디렉토리" <br>
	 * dir 맨앞과 맨뒤에는 패스구분자는 포함하지 않는다. (¥나 /등)
	 * 실재디렉토리를 생성하지 않기 때문에 실재디렉토리를 생성할경우엔 File.mkdirs()들을 사용하여 생성한다.
	 * @param subDir 기준디렉토리 맨밑의 디레토리명
	 * @return 임시디렉토리
	 */
	public static File getTemporaryDirectory(String subDir) {
		for (int i=0; i < MAKE_TEMPDIR_RETRYING_FREQUENCY; i++) {
			String tmpDirPath = null;
			if (StringUtils.isEmpty(subDir)) {
				tmpDirPath = tmpBaseDir + File.separator + getRandomString();
			} else {
				tmpDirPath = tmpBaseDir + File.separator + subDir + File.separator + getRandomString();
			}
			File dir = new File(tmpDirPath);
			if (!dir.isDirectory()) {
				try {
					FileUtils.forceMkdir(dir);
					return dir;
				} catch (IOException e) {
					log.warning(dir.getPath());
					throw new BaristaRuntimeException(MessageId.DIR_CREATION_ERROR,
							BaristaMessages.getMessage(MessageId.DIR_CREATION_ERROR));
				}
			}
			log.warning("임시폴더를 생성하지 못했습니다.: 실패" + i + "번째 " + tmpDirPath);
		}
		throw new BaristaRuntimeException(MessageId.DIR_CREATION_ERROR,
				BaristaMessages.getMessage(MessageId.DIR_CREATION_ERROR));
	}

	/**
	 * @param prefix
	 * @return
	 */
	/*
	public static File getFlexibleTempDir(String prefix) {
		for (int i=0; i < MAKE_TEMPDIR_RETRYING_FREQUENCY; i++) {
			String tmpDirPath = null;
			if (StringUtils.isEmpty(prefix)) {
				tmpDirPath = sp.getProperty(TMP_DIR_APP) + File.separator + getRandomString();
			} else {
				tmpDirPath = sp.getProperty(TMP_DIR_APP) + File.separator + prefix + "_" + getRandomString();
			}
			File dir = new File(tmpDirPath);
			if (!dir.isDirectory()) {
				try {
					FileUtils.forceMkdir(dir);
					return dir;
				} catch (IOException e) {
					log.warning(dir.getPath());
					throw new BaristaRuntimeException(MessageId.DIR_CREATION_ERROR,
							BaristaMessages.getMessage(MessageId.DIR_CREATION_ERROR));
				}
			}
			log.warning("임시폴더를 생성하지 못했습니다.: 실패" + i + "번째 " + tmpDirPath);
		}
		throw new BaristaRuntimeException(MessageId.DIR_CREATION_ERROR,
				BaristaMessages.getMessage(MessageId.DIR_CREATION_ERROR));
	}
	*/

	/**
	 * 파일의 확장자를 검증한다.
	 * 빈문자열이 확장자로 설정되었을 경우, 실패한다.
	 * @param inputFilePath 검증대상패스
	 * @param extension 예상되는 확장자
	 * @return 확장자가 일치한 경우:true, 확장자가 일치하지 않는 경우:false
	 */
	public static boolean isConsistentExtension(String inputFilePath, String extension) {
		return extension.equalsIgnoreCase(inputFilePath.substring(inputFilePath.lastIndexOf(".") + 1));
	}

	/**
	 * 파일의 확장자를 검증한다.(확장자에 복수 설정가능)
	 * @param inputFilePath 검증대상패스
	 * @param extension 예상되는 확장자의 배열
	 * @return 확장자가 일치한 경우:true, 확장자가 일치하지 않는 경우:false
	 */
	public static boolean isConsistentExtension(String inputFilePath, String[] extension) {
		for (int i=0; i < extension.length; i++) {
			if (extension[i].equalsIgnoreCase(inputFilePath.substring(inputFilePath.lastIndexOf(".") + 1))) {
				return true;
			}
		}
		return false;
	}

	/**
	 * XML파일을 결합해서 하나의 XML파일로 만듭니다.<br>
	 * 결합순서는 인수의 리스트에 담겨저있는 순서로 결합된다. <br>
	 * 파일이 XML파일인지 아닌지의 검증은 하지 않는다.
	 * @param xmlFilePathList XML파일패스리스트
	 * @param outputFilePath 출력할 파일패스
	 * @throws ParserConfigurationException 사용되고 있는 파서에서는 요구된 기능을 사용할수 없는 경우
	 * @throws SAXException 파일을 읽어들일때 에러가 발생한 경우
	 * @throws IOException XML데이터가 바르지 않는 경우
	 * @throws XPathExpressionException XML규약에 위반하고 있을경우
	 */
	public static void mergeXlm(List<String> xmlFilePathList, String outputFilePath)
			throws ParserConfigurationException, SAXException, IOException, XPathExpressionException {
		File outfile = new File(outputFilePath);
		if (xmlFilePathList.size() < 2) {
			throw new IllegalArgumentException("2개 이상의 XML파일을 설정해주세요.");
		} else if (outputFilePath.length() < 1 || outfile.isDirectory()) {
			throw new IllegalArgumentException("출력파일패스가 바르지 않습니다.");
		}

		DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		Document baseXml = builder.parse(new File(xmlFilePathList.get(0)));
		XPath xpath = XPathFactory.newInstance().newXPath();
		XPathExpression ex = xpath.compile("/*/*");
		Node rootNode = baseXml.getDocumentElement();

		for (int i=0; i < xmlFilePathList.size(); i++) {
			Document importXml = builder.parse(new File(xmlFilePathList.get(i + 1)));
			NodeList importXmlNodeList = (NodeList) ex.evaluate(importXml, XPathConstants.NODESET);
			for (int j=0; j < importXmlNodeList.getLength(); j++) {
				Node importNode = baseXml.importNode(importXmlNodeList.item(j), true);
				rootNode.appendChild(importNode);
			}
		}
	}

	/**
	 * 클래스패스상에 있는 파일을 얻어 지정된 패스에 파일을 생성한다.<br>
	 * 취득한 파일과 같은이름을 지정할 경우, 패스며에 파일명을 지정한다.
	 * @param outputFilePath 출력패스(파일명을 포함)
	 * @param fileName 취득한 파일명
	 * @throws IOException IO에러가 발생한 경우
	 */
	public static void getFileInJar(String outputFilePath, String fileName) throws IOException {
		if (fileName.length() < 1 || outputFilePath.length() < 1) {
			throw new IllegalArgumentException("올바르지 않은 인수가 지정되었습니다.");
		}
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		FileOutputStream fos = new FileOutputStream(outputFilePath);
		byte[] buff = new byte[GET_FILE_IN_JAR_BUFFER_SIZE];
		InputStream in = null;
		try {
			in = cl.getResourceAsStream(fileName);
			int b = 0;
			while ((b = in.read(buff)) != -1) {
				fos.write(buff, 0, b);
			}
		} finally {
			fos.close();
			IOUtils.closeQuietly(in);
		}
	}

	/**
	 * 파일, 디렉토리를 삭제한다.
	 * 삭제시에 예외가 발생했을경우 로그만 남긴다.
	 * @param dir 삭제대상 디렉토리
	 */
	public static void deleteFile(File dir) {
		if (dir != null && dir.getPath().length() != 0) {
			if (dir.isFile() || dir.isDirectory()) {
				if (!FileUtils.deleteQuietly(dir)) {
					log.info("입력된 " + dir.getPath() + "의 삭제에 실패했습니다.");
				}
			}
		}
	}

	/**
	 * 파일, 디렉토리를 삭제한다.
	 * 삭제시에 예외가 발생했을경우 로그만 남긴다.
	 * @param dirPath 삭제대상의 디렉토리의 파일패스
	 */
	public static void deleteFile (String dirPath) {
		if (StringUtils.isNotEmpty(dirPath)) {
			deleteFile(new File(dirPath));
		}
	}
}
