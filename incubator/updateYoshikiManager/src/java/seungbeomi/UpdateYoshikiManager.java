package seungbeomi;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import seungbeomi.util.XmlDocument;
import seungbeomi.util.ZipFile;

public class UpdateYoshikiManager {

	private final static Log log = LogFactory.getLog(UpdateYoshikiManager.class);

	private static UpdateYoshikiManagerDao yoshikiDao;

	private static String filePath;
	private static final String MASTER_XML = "_master.xml";

	// XPATH
	private static final String XPATH_YOSHIKI_ID = "/手続情報/手続属性/手続ID";
	private static final String XPATH_TETSUZUKI_YUKO_KAISHIBI = "/手続情報/手続属性/手続有効開始日";
	private static final String XPATH_VERSION = "/手続情報/手続属性/バージョン";

	public static void main(String[] args) {

		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		yoshikiDao = (UpdateYoshikiManagerDao) context.getBean("updateYoshikiManagerDao");

		try {
			filePath = args[0];
		} catch (ArrayIndexOutOfBoundsException e) {
			log.fatal(e.toString());
			return;
		}

		new UpdateYoshikiManager().execute();
	}

	public void execute() {
		String yoshikiId;

		log.info("start...");
		File yoshikiZipFilePath = new File(filePath);
		if (yoshikiZipFilePath.isDirectory()) {
			File[] files = yoshikiZipFilePath.listFiles();
			for (File file : files) {
				// Extract zip file
				ZipFile zipfile = new ZipFile(filePath + File.separator + file.getName());
				try {
					zipfile.extract(filePath);

					yoshikiId = file.getName().replace(".xml", "");

					// create yoshiki
					DefaultShinseishoYoshiki yoshiki = createYoshiki(yoshikiId, filePath);

					// update yoshiki
					yoshikiDao.update(yoshiki);
				} catch (Exception e) {
					log.fatal(e.toString());
				}

			}
		}
		log.info("end...");
	}

	private DefaultShinseishoYoshiki createYoshiki(String yoshikiId, String filePath) {
		XmlDocument xml;
		String fullPath;
		String yoshikiFilePath;
		String yoshikiFileData;
		DefaultShinseishoYoshiki created;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		created = new DefaultShinseishoYoshiki();
		//fullPath = filePath + File.separator + yoshikiId + File.separator + yoshikiId + MASTER_XML;
		fullPath = "/workspace/webproject/updateYoshikiManager/testData/t001_master.xml";
		xml = new XmlDocument(fullPath);

		try {
			created.setYoshikiId(xml.getTagValue(XPATH_YOSHIKI_ID));
			created.setTetsuzukiYukoKaishibi(sdf.parse(xml.getTagValue(XPATH_TETSUZUKI_YUKO_KAISHIBI)));
			created.setVersion(Integer.parseInt(xml.getTagValue(XPATH_VERSION)));

			// CLOB data
			yoshikiFilePath = filePath + File.separator + yoshikiId + MASTER_XML;
			yoshikiFileData = readFileData(yoshikiFilePath);
			created.setYoshikiFileData(yoshikiFileData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return created;
	}

	private String readFileData(String yoshikiFilePath) {
		FileReader fr;
		BufferedReader br;
		StringBuffer data;
		String readLineData;

		try {
			fr = new FileReader(yoshikiFilePath);
			br = new BufferedReader(fr);
			data = new StringBuffer();

			while ((readLineData = br.readLine()) != null) {
				data.append(readLineData + "¥r¥n");
			}
			br.close();
			return data.toString().trim();
		} catch (IOException e) {
			log.fatal(e.toString());
			throw new RuntimeException();
		}
	}

}
