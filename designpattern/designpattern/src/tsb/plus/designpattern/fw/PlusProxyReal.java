package tsb.plus.designpattern.fw;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusProxyReal implements PlusProxy {
	
	@Override
	public Result send(Param param) {
		
		System.out.println("Proxy::Real 메소드 실행");
		
		PlusDelegate delegate = new PlusDelegateImpl();
		Result result = delegate.run(param);
		
		return result;
	}

}
