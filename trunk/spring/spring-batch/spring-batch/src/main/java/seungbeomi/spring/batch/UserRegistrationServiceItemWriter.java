package seungbeomi.spring.batch;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.log4j.Logger;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

public class UserRegistrationServiceItemWriter implements ItemWriter<UserRegistration> {

	private Logger logger = Logger.getLogger(getClass());
	
	// HTTP Invoker 서비스의 클라이언트 인터페이스
	@Autowired
	private UserRegistrationService userRegistrationService;
	
	@Override
	public void write(List<? extends UserRegistration> items) throws Exception {
		for (UserRegistration userRegistration : items) {
			UserRegistration registrationUser = userRegistrationService.registerUser(userRegistration);
			logger.debug("Registered : " + ToStringBuilder.reflectionToString(registrationUser));
		}
	}

}
