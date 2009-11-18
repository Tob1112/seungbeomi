package validators;

import java.io.IOException;
import java.io.InputStream;
import java.text.MessageFormat;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.commons.validator.Field;
import org.apache.commons.validator.Form;
import org.apache.commons.validator.Validator;
import org.apache.commons.validator.ValidatorAction;
import org.apache.commons.validator.ValidatorException;
import org.apache.commons.validator.ValidatorResources;
import org.apache.commons.validator.ValidatorResult;
import org.apache.commons.validator.ValidatorResults;
import org.xml.sax.SAXException;

public class ValidatorExample {

	private static ResourceBundle apps = ResourceBundle.getBundle("validators.applicationResources");

	public static void main(String[] args) throws IOException, SAXException, ValidatorException {
		InputStream in = null;
		ValidatorResources resources = null;

		in = ValidatorExample.class.getResourceAsStream("validator-example.xml");
		try {
			resources = new ValidatorResources(in);
		} finally {
			if (in != null) {
				in.close();
			}
		}

		//테스트 빈 생성
		ValidateBean bean = new ValidateBean();

		Validator validator = new Validator(resources, "ValidateBean");

		validator.setParameter(Validator.BEAN_PARAM, bean);

		ValidatorResults results = null;

		results = validator.validate();

		printResults(bean, results, resources);

		bean.setName("son");
		bean.setEmail("seungbeomi@gmail.com");
		bean.setAge(31);
		results = validator.validate();
		printResults(bean, results, resources);

	}

	private static void printResults(ValidateBean bean,
			ValidatorResults results, ValidatorResources resources) {
		boolean success = true;

        // Start by getting the form for the current locale and Bean.
        Form form = resources.getForm(Locale.getDefault(), "ValidateBean");

        System.out.println("\n\nValidating:");
        System.out.println(bean);

        // Iterate over each of the properties of the Bean which had messages.
        Iterator propertyNames = results.getPropertyNames().iterator();
        while (propertyNames.hasNext()) {
            String propertyName = (String) propertyNames.next();

            // Get the Field associated with that property in the Form
            Field field = form.getField(propertyName);

            // Look up the formatted name of the field from the Field arg0
            String prettyFieldName = apps.getString(field.getArg(0).getKey());

            // Get the result of validating the property.
            ValidatorResult result = results.getValidatorResult(propertyName);

            // Get all the actions run against the property, and iterate over their names.
            Map actionMap = result.getActionMap();
            Iterator keys = actionMap.keySet().iterator();
            while (keys.hasNext()) {
                String actName = (String) keys.next();

                // Get the Action for that name.
                ValidatorAction action = resources.getValidatorAction(actName);

                // If the result is valid, print PASSED, otherwise print FAILED
                System.out.println(
                    propertyName
                        + "["
                        + actName
                        + "] ("
                        + (result.isValid(actName) ? "PASSED" : "FAILED")
                        + ")");

                //If the result failed, format the Action's message against the formatted field name
                if (!result.isValid(actName)) {
                    success = false;
                    String message = apps.getString(action.getMsg());
                    Object[] args = { prettyFieldName };
                    System.out.println(
                        "     Error message will be: "
                            + MessageFormat.format(message, args));

                }
            }
        }
        if (success) {
            System.out.println("FORM VALIDATION PASSED");
        } else {
            System.out.println("FORM VALIDATION FAILED");
        }

	}
}
