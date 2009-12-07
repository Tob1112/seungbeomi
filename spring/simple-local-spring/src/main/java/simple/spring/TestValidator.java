package simple.spring;

import org.apache.commons.validator.Field;
import org.apache.commons.validator.GenericValidator;
import org.apache.commons.validator.util.ValidatorUtils;

public class TestValidator {

	public static boolean validateRequired(Object bean, Field field) {
	      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

	      return !GenericValidator.isBlankOrNull(value);
	   }

}
