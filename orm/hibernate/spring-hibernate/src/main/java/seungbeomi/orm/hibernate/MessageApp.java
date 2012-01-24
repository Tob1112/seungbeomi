package seungbeomi.orm.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MessageApp {
	
	private static Logger logger = Logger.getLogger(MessageApp.class);
	
	public static void main(String[] args) {
		
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath:META-INF/spring/app-context.xml");
		MessageDao messageDao = (MessageDao) context.getBean("messageDao");
		
		// 1st work
		Message message = new Message();
		message.setText("hello world");
		Long mesId = messageDao.save(message);
		
		// 2nd work
		List<Message> messages = messageDao.find();
		logger.debug(messages.size() + " message(s) found.");
		
		for (Message m : messages) {
			logger.debug(m.getText());
		}
		
		// 3th work
		Message getMessage = messageDao.get(Message.class, mesId);
		getMessage.setText("Greeting Earthling");
		getMessage.setNextMessage(new Message("Take me to your leader (please)"));
		logger.debug(">>> getMessage : " + getMessage);
	}

}