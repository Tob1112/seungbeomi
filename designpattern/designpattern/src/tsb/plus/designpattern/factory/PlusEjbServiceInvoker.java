package tsb.plus.designpattern.factory;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusEjbServiceInvoker extends PlusServiceInvoker {

	@Override
	public Result invoke(Param param) {
		System.out.println("Factory::PlusEjbServiceInvoker 실행");
		
		Result result = new Result();
		result.setName(param.getName());
		result.setAge(34);
		result.setCompany("TSB");
		
		return result;
	}

}
