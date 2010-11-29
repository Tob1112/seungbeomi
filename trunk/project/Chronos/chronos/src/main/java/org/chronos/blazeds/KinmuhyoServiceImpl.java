package org.chronos.blazeds;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.barista.common.util.SystemUtiltity;
import org.barista.common.util.ZipFile;
import org.barista.common.xml.XmlDocument;
import org.chronos.domain.Shinsei;
import org.chronos.domain.ChronosEnum.ShinseiKubun;


public class KinmuhyoServiceImpl implements KinmuhyoService {

	private static final Logger log = Logger.getLogger(KinmuhyoServiceImpl.class);
	private static final long MAX_ZIP_FILE_SIZE = 1024;

	@Override
	public void addKinmuhyo() {
		// TODO Auto-generated method stub

	}

	private static final String XPATH_NENGETSU 		= "/勤務表/勤務表/@年月";
	private static final String XPATH_KAISHA_KUBUN 	= "XX";
	private static final String XPATH_SHAIN_BANGO 	= "/勤務表/勤務表/@社員番号";
	private static final String XPATH_SHINSEI_KUBUN = "/勤務表";
	private static final String XPATH_KINMUHYO 		= "/勤務表/勤務表";

	/** 勤務表XMLファイル保存 */
	@Override
	public Shinsei saveKinmuhyo(Shinsei shinsei) {
		// sessionIdを使用し、tmp directory作成
		File tmpDir = SystemUtiltity.getTemporaryDirectory();
		log.debug("path : " + tmpDir.getAbsolutePath());

		prepareUploadDate(shinsei, tmpDir);

		File kinmuhyoFile = null;
		String[] files = tmpDir.list();
		for (int i=0 ; i < files.length; i++) {
			if (files[i].endsWith(".xml")) {
				kinmuhyoFile = new File(tmpDir.getAbsoluteFile() + File.separator + files[i]);
			}
		}

		XmlDocument kinmuhyoXml = new XmlDocument(kinmuhyoFile);

		// 申請番号生成
		String nengetsu = kinmuhyoXml.getAttributeValue(XPATH_NENGETSU).replace("-", "");
		String shainBango = kinmuhyoXml.getAttributeValue(XPATH_SHAIN_BANGO);

		String shinseiBango = nengetsu + shainBango + ShinseiKubun.KINMUHYO;
		System.out.println("shinseiBango : " + shinseiBango);



		// DB保存


		// tmp directory削除
		//SystemUtiltity.deleteFile(tmpDir);

		return null;
	}

	private String prepareUploadDate(Shinsei shinsei, File toDir) {
		File receivedFile = null;
		byte[] receivedData = shinsei.getShinseiData();
		String outDirPath = toDir.getAbsolutePath();
		InputStream in = null;
		OutputStream out = null;

		try {
			receivedFile = File.createTempFile("dataset", ".zip");

			in = new ByteArrayInputStream(receivedData);
			out = new FileOutputStream(receivedFile);
			IOUtils.copy(in, out);

			if (receivedFile.length() > MAX_ZIP_FILE_SIZE) {
				log.debug("ZIPファイルサイズの制限超過しています。[" + receivedFile.length() + "]");
				return "TOO_LARGE_FILE";
			}

			new ZipFile(receivedFile.getAbsolutePath(), "UTF-8").extract(outDirPath);
			log.debug("申請データの展開先：" + outDirPath);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(in);
			IOUtils.closeQuietly(out);
			if (!receivedFile.delete()) {
				log.info("申請ファイルが削除できませんでした。：" + receivedFile.getAbsolutePath());
			}
		}
		return "SUCCESS";
	}


}
