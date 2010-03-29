package util;

import java.io.File;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.PropertyConfigurator;

public class Log4jReLoadConfigure extends HttpServlet {
    /** Initializa el servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        String prefix =  getServletContext().getRealPath("/")+"WEB-INF"+File.separatorChar+"classes"+File.separatorChar;

        String file = getInitParameter("log4j-init-file");

        if(file == null || file.length() == 0 ||
                !(new File(prefix+file)).isFile()){
                System.err.println("[ERROR]: File not found log4j.properties OR log4j.xml ");
                throw new ServletException();
        }
        
        // reload time set
        String watch = config.getInitParameter("watch");
        String timeWatch = config.getInitParameter("time-watch");

        if (watch != null && watch.equalsIgnoreCase("true")) {
            if (timeWatch != null) {
                PropertyConfigurator.configureAndWatch(prefix+file,Long.parseLong(timeWatch));
            } else {
                PropertyConfigurator.configureAndWatch(prefix+file);
            }
        } else {
            PropertyConfigurator.configure(prefix+file);
        }

    }

    public void destroy() {
        super.destroy();
    }

}
