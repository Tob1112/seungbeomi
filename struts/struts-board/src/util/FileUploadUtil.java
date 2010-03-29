package util;

//import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.struts.upload.FormFile;

import board.model.BoardFile;

public class FileUploadUtil {

	public static BoardFile doFileUpload(FormFile fileList)
		throws FileNotFoundException, IOException {
		
//		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		InputStream stream = fileList.getInputStream();

		//System.currentTimeMillis를 새로운 파일을 업로드 할때의 임시이름으로 하여
		//꺼내올때 사용하도록 한다.
		String newFileName = Long.toString(System.currentTimeMillis());

		//파일을 업로드할 절대 경로를 지정해야 한다. 
		String path =
			"E:\\PROJECT\\Project_prt_src\\Upload_file\\";
		OutputStream bos = new FileOutputStream(path + newFileName);
		int bytesRead = 0;
		byte[] buffer = new byte[8192];
		while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
			bos.write(buffer, 0, bytesRead);
		}
		bos.close();
		stream.close();

		BoardFile boardFile = new BoardFile();
		boardFile.setFileName(fileList.getFileName());
		boardFile.setTempFileName(newFileName);

		return boardFile;
	}
}
