package servlet;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownloadServlet2 extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DownloadServlet2() {
		super();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {

		doGet(request,response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fileName = request.getParameter("fileName");
		String tempFileName = request.getParameter("tempFileName");

		File file = new File("E:/PROJECT/Project_prt_src/Upload_file/"+tempFileName);

		DataInputStream in = new DataInputStream(new FileInputStream(file));
		ServletOutputStream out = response.getOutputStream();
		response.reset();

		//확장자 구별
//		String whatExt = "";
//		if(fileName != null){
//			whatExt = fileName.substring(fileName.length()-4,fileName.length());
//
//			if(".doc".equals(whatExt)){
//				//MS word file
//				response.setContentType("application/msword; charset=euc-kr");
//			}
//			else if(".pdf".equals(whatExt)){
//				//pdf file
//				response.setContentType("application/pdf; charset=euc-kr");
//			}
//			else if(".jpg".equals(whatExt)){
//				//jpg file
//				response.setContentType("application/jpeg; charset=euc-kr");
//			}
		response.setHeader("Content-Type", "application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);

		/*
		 * response.setHeader("Content-Disposition","filename="+fileName+";");
		 * 이것 처럼 attachement; 가 빠지면 브라우져에서 바로 열리고
		 * response.setHeader("Content-Disposition","attachment;filename="+fileName+";");
		 * 이것 처럼 달려 있으면 다이얼로그 창이 뜬다.
		 */

//		byte buffer[] = new byte[1024];
//		byte tmp;
//		int x = 0;
//		long count = 0;

		long size = file.length();

		try{
			byte tm;
			for (int i=0 ; i < size; i++){
				tm = in.readByte();
				out.write(tm);
			}
		}
		finally{
			out.close();
			in.close();
		}
	}



}

