package spring.jdktimer;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class MethodInvokingTimerTaskExample {
	public static void main(String[] args) throws IOException {
		ApplicationContext ctx = new FileSystemXmlApplicationContext("src/spring/jdktimer/MethodInvokingTimerTaskExample-context.xml");
		System.in.read();
	}

}
