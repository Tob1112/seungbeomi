package tsb.plus.designpattern.delegate;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusRemoteObject {

	public Result execute(Param param) {
		Result result = new Result();
		result.setName(param.getName());
		result.setAge(34);
		result.setCompany("TSB");
		return result;
	}
	
}
