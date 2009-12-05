package simple.spring;

import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;

public class SimpleSpring {

	public static void main(String[] args) {
		 XmlBeanFactory factory = new XmlBeanFactory(new ClassPathResource("applicationContext.xml"));
		 HelloSpring hello = (HelloSpring)factory.getBean("helloSpring");
		 hello.getMessage();
	}
}
