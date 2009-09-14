package spring.jdktimer;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class TimerFactoryBeanExample {
	public static void main(String[] args) throws IOException {
		//ApplicationContext ctx = new FileSystemXmlApplicationContext("src/spring/jdktimer/TimerFactoryBeanExample-context.xml");
		ApplicationContext ctx = new FileSystemXmlApplicationContext("src/spring/jdktimer/BirthdayScheduledTask-context.xml");
		System.in.read();
	}
}
