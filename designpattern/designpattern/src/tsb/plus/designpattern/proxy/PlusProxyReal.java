package tsb.plus.designpattern.proxy;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusProxyReal implements PlusProxy {
	
	@Override
	public Result send(Param param) {
		
		System.out.println("Proxy::Real 메소드 실행");
		
		Result result = new Result();
		result.setName("seungbeomi");
		result.setAge(34);
		result.setCompany("TSB");
		
		return result;
	}

}
