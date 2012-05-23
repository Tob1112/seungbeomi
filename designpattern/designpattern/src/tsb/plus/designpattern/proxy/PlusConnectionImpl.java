package tsb.plus.designpattern.proxy;

import tsb.plus.designpattern.delegate.PlusDelegate;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusConnectionImpl implements PlusConnection {
	
	private PlusDelegate plusDelegate;

	public PlusConnectionImpl(PlusDelegate plusDelegate) {
		this.plusDelegate = plusDelegate;
	}

	@Override
	public Result send(Param param) {
		
		System.out.println("Proxy::Real 메소드 실행");
		
		Result result = plusDelegate.send(param);
		
		return result;
	}

}
