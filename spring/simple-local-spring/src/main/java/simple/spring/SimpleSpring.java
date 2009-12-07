package simple.spring;

import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.validator.ValidatorException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.MessageSourceAccessor;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.xml.sax.SAXException;

public class SimpleSpring {

	private static HelloSpring helloSpring;
	private static MessageSourceAccessor messageSource;
	private static DefaultBeanValidator beanValidator;

	public void setHelloSpring(HelloSpring helloSpring) {
		this.helloSpring = helloSpring;
	}

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = new MessageSourceAccessor(messageSource);
	}

	public void setBeanValidator(DefaultBeanValidator beanValidator) {
		this.beanValidator = beanValidator;
	}

	public static void main(String[] args) throws IOException, SAXException, ValidatorException {
		Log logger = LogFactory.getLog(SimpleSpring.class);

		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

		logger.info("<<< Dependency Injection Test");
		helloSpring.getMessage();

		logger.info("<<< MessageSource Test");
		System.out.println(messageSource.getMessage("name"));

		logger.info("<<< commons validation Test");

		User user = new User();
		user.setUserId("son");
		user.setPassword("son");

		SimpleValidator<User, String> validator = new SimpleValidator<User, String>();
		validator.validate(user, "user");
	}
}
