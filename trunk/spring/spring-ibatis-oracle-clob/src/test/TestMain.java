package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestMain {
	
	public static void main(String[] args) {
		ApplicationContext appContext =
			new ClassPathXmlApplicationContext("applicationContext.xml");
		TestDao dao = (TestDao)appContext.getBean("testDao");
		
		int id = 3;

		dao.insert(id);
		
		System.out.println(dao.select(id));
	}
}
