package simple.spring;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.validator.Validator;
import org.apache.commons.validator.ValidatorException;
import org.apache.commons.validator.ValidatorResources;
import org.apache.commons.validator.ValidatorResults;
import org.xml.sax.SAXException;

public class SimpleValidator<T, PK extends String> {

	InputStream in = null;
    ValidatorResources resources = null;

	public SimpleValidator() throws IOException, SAXException {
		try{
			in = SimpleValidator.class.getResourceAsStream("validator-example.xml");
			resources = new ValidatorResources(in);
		} finally {
			if (in != null) {
				in.close();
			}
		}
	}

	public void validate(T bean, PK key) throws ValidatorException{
		Validator validator = new Validator(resources, key);
		validator.setParameter(Validator.BEAN_PARAM, bean);
		ValidatorResults results = validator.validate();
	}
}