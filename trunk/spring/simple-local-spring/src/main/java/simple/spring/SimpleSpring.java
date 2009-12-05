package simple.spring;

import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.MessageSourceAccessor;

public class SimpleSpring {

	private static HelloSpring helloSpring;
	private static MessageSourceAccessor messageSource;

	public void setHelloSpring(HelloSpring helloSpring) {
		this.helloSpring = helloSpring;
	}
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = new MessageSourceAccessor(messageSource);
	}

	public static void main(String[] args) {
		 ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

		 helloSpring.getMessage();

		 System.out.println(messageSource.getMessage("name"));

	}
}
