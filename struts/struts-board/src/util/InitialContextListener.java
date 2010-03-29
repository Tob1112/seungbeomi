package util;
/*
   <context-param>
        <param-name>jdbcUrl</param-name>
			<param-value>jdbc:oracle:thin:@localhost:1521:SEMSID</param-value>
  </context-param>
  <context-param>
        <param-name>jdbcUser</param-name>
			<param-value>scott</param-value>
  </context-param>
  <context-param>
        <param-name>jdbcPw</param-name>
			<param-value>tiger</param-value>
  </context-param>
   <listener>
       <listener-class>util.InitialContextListener</listner-class>
	   </listener>
*/

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.h2.jdbcx.JdbcConnectionPool;
import org.h2.jdbcx.JdbcDataSource;

//server의 start와 stop에 반응하는 listener
//ServletContextListener을
public class InitialContextListener  implements ServletContextListener{
    //OraclePooledConnection pool=null;
	JdbcConnectionPool pool = null;
	JdbcDataSource ds = null;

   public void contextDestroyed(ServletContextEvent sce) {
	   System.out.println("Struts 서버종료...");

   }
   public void  contextInitialized(ServletContextEvent sce) {
	   System.out.println("Struts 서버시작...");

	   ServletContext context=sce.getServletContext();

	   //드라이버 정보는 자동으로 로딩해준다 url, user,pw만 설정하고 parameter에
       String url=context.getInitParameter("jdbcUrl");
       String user=context.getInitParameter("jdbcUser");
       String pw=context.getInitParameter("jdbcPw");

       ds = new JdbcDataSource();
       ds.setURL(url);
       ds.setUser(user);
       ds.setPassword(pw);
     try{
	    //pool=new OraclePooledConnection(url,user,pw);
    	 pool = JdbcConnectionPool.create(ds);
	 }catch(Exception e){}
	   NamingService ns=NamingService.getInstance();
       ns.setAttribute("pool",pool);

   }
}

