package seungbeomi.spring.batch;

import org.apache.commons.lang.StringUtils;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.stereotype.Component;

@Component("userRegistrationValidationItemProcessor")
public class UserRegistrationValidationItemProcessor implements ItemProcessor<UserRegistration, UserRegistration> {

	@Override
	public UserRegistration process(UserRegistration input) throws Exception {
		String zip = stripNonNumber(input.getZip());
		String telephone = stripNonNumber(input.getPhoneNumber());
		String state = StringUtils.defaultString(input.getState());
		if (isTelephoneValid(telephone) && isZipValid(zip) && isStateValid(state)) {
			input.setZip(zip);
			input.setPhoneNumber(telephone);
			return input;
		}
		return null;
	}
	
	private String stripNonNumber(String input) { return input; }
	private boolean isTelephoneValid(String input) { return true; }
	private boolean isZipValid(String input) { return true; }
	private boolean isStateValid(String input) { return true; }

}
