package quartz;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class SimpleSpringQuartzIntegrationExample {

	public static void main(String[] args) {
		ApplicationContext ctx = new FileSystemXmlApplicationContext("src/quartz/SimpleSpringQuartzIntegrationExample-scheduler.xml");
	}
}

