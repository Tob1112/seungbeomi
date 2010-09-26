package seungbeomi;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import seungbeomi.util.XmlDocument;
import seungbeomi.util.ZipFile;

public class UpdateYoshikiManager {

	private static UpdateYoshikiManagerDao yoshikiDao;

	private static final String MASTER_XML = "_master.xml";

	// XPATH
	private static final String XPATH_YOSHIKI_ID = "/手続情報/手続属性/手続ID";
	private static final String XPATH_TETSUZUKI_YUKO_KAISHIBI = "/手続情報/手続属性/手続有効開始日";
	private static final String XPATH_VERSION = "/手続情報/手続属性/バージョン";

	public static void main(String[] args) {

		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		yoshikiDao = (UpdateYoshikiManagerDao) context.getBean("updateYoshikiManagerDao");

		new UpdateYoshikiManager().updateYoshiki();
	}

	public void updateYoshiki() {
		String filePath = "/workspace/webproject/updateYoshikiManager/testData";
		String yoshikiId = "t001";

		// Extract zip file
		/*
		ZipFile zipfile = new ZipFile(filePath + File.separator + yoshikiId + ".zip");
		try {
			zipfile.extract(filePath);
		} catch (IOException e) {
			e.printStackTrace();
		}
		 */

		// create yoshiki
		DefaultShinseishoYoshiki yoshiki = createYoshiki(yoshikiId, filePath);
		// update yoshiki
		updateYoshiki(yoshiki);

	}

	private DefaultShinseishoYoshiki createYoshiki(String yoshikiId, String filePath) {
		String fullPath;
		XmlDocument xml;
		DefaultShinseishoYoshiki created;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		created = new DefaultShinseishoYoshiki();
		//fullPath = filePath + File.separator + yoshikiId + File.separator + yoshikiId + MASTER_XML;
		fullPath = "/workspace/webproject/updateYoshikiManager/testData/t001_master.xml";
		xml = new XmlDocument(fullPath);

		try {
			created.setYoshikiId(xml.getTagValue(XPATH_YOSHIKI_ID));
			//created.setYoshikiFileData(xml.getTagValue(XPATH_YOSHIKI_FILE_DATA));
			created.setTetsuzukiYukoKaishibi(sdf.parse(xml.getTagValue(XPATH_TETSUZUKI_YUKO_KAISHIBI)));
			created.setVersion(Integer.parseInt(xml.getTagValue(XPATH_VERSION)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return created;
	}


	private void updateYoshiki(DefaultShinseishoYoshiki yoshiki) {
		StringBuffer sql = new StringBuffer();
		sql.append("INSERT INTO YOSHIKI (YOSHIKI_ID, TETSUZUKI_YUKO_KAISHIBI, VERSION) VALUES (");
		sql.append(yoshiki.getYoshikiId() + "," + yoshiki.getTetsuzukiYukoKaishibi() + "," + yoshiki.getVersion());
		sql.append(")");

		System.out.println(sql);

	}
}
