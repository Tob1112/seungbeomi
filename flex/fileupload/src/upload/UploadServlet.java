package upload;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html; charset=Shift_JIS");
        PrintWriter out = resp.getWriter();

        req.setCharacterEncoding("Shift-JIS");

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Upload Test!</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>FileUpload Test</h1>");
        out.println("</body>");
        out.println("</html>");

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //String path = getServletContext().getRealPath("WEB-INF/data");
        String path = "/development/ide/eclipse/workspace/fileupload/WebContent/WEB-INF/data";

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        try {
            List list = sfu.parseRequest(request);
            Iterator iterator = list.iterator();
            while (iterator.hasNext()) {
                FileItem item = (FileItem) iterator.next();
                /* 取り出したFileItemに対する処理 */
                if (!item.isFormField()) {
                    // アップロードファイルの元ファイル名を取得
                    String strNam = item.getName();
                    if (strNam != null && !strNam.equals("")) {
                        strNam = (new File(strNam)).getName();
                        try {
                            item.write(new File(path + "/" + strNam));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();
        out.print("success");
    }
}
