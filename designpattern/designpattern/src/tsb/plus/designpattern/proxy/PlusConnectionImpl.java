package tsb.plus.designpattern.proxy;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusConnectionImpl implements PlusConnection {

	@Override
	public Result send(Param param) {
		Result result = new Result();
		result.setName(param.getName());
		result.setAge(34);
		result.setCompany("TSB");
		return result;
	}

}
