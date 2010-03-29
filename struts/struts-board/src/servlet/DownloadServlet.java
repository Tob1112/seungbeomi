package servlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.BoardUtils;


/**
 * @web.servlet name="Download" 
 * 				display-name="File Download Servlet"
 * 				
 * @web.servlet-mapping url-pattern="/Download"
 */
public class DownloadServlet extends HttpServlet {

	protected void performTask(
		javax.servlet.http.HttpServletRequest request,
		javax.servlet.http.HttpServletResponse response)
		throws Exception {

		
		String tempFileName = request.getParameter("tempFileName");
		String fileName = request.getParameter("fileName");
		
		System.out.println("getPathInfo is : "+request.getPathInfo());
		System.out.println("getRealPath (/) is : "+request.getRealPath("/"));
		System.out.println("getRequestURI is : "+request.getRequestURI());
		System.out.println("getContextPath is : "+request.getContextPath());
		System.out.println("getServletPath is : "+request.getServletPath());
		
		try {
			//파일이 경로를 만들어 주는것 같다 나는 내가 집적넣겠다.
//			String rootPath = request.getRealPath("/");
//			String filePath =
//				rootPath + "upload" + File.separator + tempFileName;
			
			String filePath = "E:/PROJECT/Project_prt_src/Upload_file/";
			
			java.io.File tempFile = new java.io.File(filePath);


			fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
			//한글을 변환하기 위해 쓰는것 같은데..
			fileName = BoardUtils.kscToasc(fileName);
//			fileName = new String(fileName.getBytes("euc-kr"),"8859_1"); 


			//이것은 안쓰는것 같다.
			int filesize = (int) tempFile.length();
			String filetype = "application/x-zip-compressed";
			String fileExt  = fileName.substring(fileName.lastIndexOf(".")+1);		

			String agentType = request.getHeader("Accept-Encoding");

			try {
				if (!tempFile.exists() || !tempFile.canRead()) {
					PrintWriter out = response.getWriter();
					out.println(
						"<script>alert('File Not Found');history.back();</script>");
					return;
				}
			} catch (Exception e) {
				PrintWriter out = response.getWriter();
				out.println(
					"<script>alert('File Not Found');history.back();</script>");
				return;
			}

			boolean flag = false;
			if (agentType != null && agentType.indexOf("gzip") >= 0)
				flag = true;

			flag = false;

			if (flag) {
				response.setHeader("Content-Encoding", "gzip");
				response.setHeader(
					"Content-disposition",
					"attachment;filename=" + fileName);
				
				javax.servlet.ServletOutputStream servletoutputstream =
					response.getOutputStream();
				
				java.util.zip.GZIPOutputStream gzipoutputstream =
					new java.util.zip.GZIPOutputStream(servletoutputstream);
				
				dumpFile(tempFile, gzipoutputstream);
				
				gzipoutputstream.close();
				servletoutputstream.close();
			} else {
				response.setContentType("application/octet-stream");
				response.setHeader(
					"Content-disposition",
					"attachment;filename=" + fileName);
				javax.servlet.ServletOutputStream servletoutputstream1 =
					response.getOutputStream();
				dumpFile(tempFile, servletoutputstream1);
				servletoutputstream1.flush();
				servletoutputstream1.close();
			}

		} catch (Exception e) {
			PrintWriter out = response.getWriter();

			out.println(
				"<script>alert('File Not Found');history.back();</script>");
			return;
		}

		return;
	}

	private void dumpFile(File realFile, OutputStream outputstream) {
		byte readByte[] = new byte[4096];
		try {
			BufferedInputStream bufferedinputstream =
				new BufferedInputStream(new FileInputStream(realFile));
			int i;
			while ((i = bufferedinputstream.read(readByte, 0, 4096)) != -1)
				outputstream.write(readByte, 0, i);
			bufferedinputstream.close();
		} catch (Exception _ex) {
		}
	}
	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		doPost(req, resp);
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		try {
			performTask(req, resp);
		} catch (Exception e) {
			throw new ServletException(e.getMessage());
		}
	}

}