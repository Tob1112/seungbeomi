package validator {
    import mx.validators.Validator;
    import mx.validators.ValidationResult;

    public class Validator_customValidator extends Validator{

    	private var results:Array;

        public function Validator_customValidator() {
        	super();
        }

        override protected function doValidation(value:Object):Array {
        	trace("doValidator");
        	results = [];
        	results = super.doValidation(value);
        	if (value != null) {
        		var pattern:RegExp = new RegExp("[a-z]+","");
        		if (value.search(pattern) == -1) {
        			results.push(new ValidationResult(true, null, "test", "소문자만입력"));
        		}
        	}
        	return results;
        }

    }
}