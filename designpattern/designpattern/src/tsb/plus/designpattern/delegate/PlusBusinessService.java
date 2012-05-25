package tsb.plus.designpattern.delegate;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusBusinessService {
	
	public Result execute(Param param) {
		
		Result result = new Result();
		result.setName("seungbeomi");
		result.setAge(34);
		result.setCompany("TSB");
		
		return result;
	}
	
}
