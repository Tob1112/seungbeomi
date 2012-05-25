package tsb.plus.designpattern.fw;

import tsb.plus.designpattern.factory.PlusFactory;
import tsb.plus.designpattern.factory.PlusServiceFactory;
import tsb.plus.designpattern.factory.PlusServiceInvoker;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusDelegateImpl implements PlusDelegate {

	@Override
	public Result run(Param param) {
		System.out.println("Delegate::Delegate 메소드 실행");
		
		PlusFactory factory = new PlusServiceFactory();
		PlusServiceInvoker serviceInvoker = factory.getServiceInvoker("spring"); // ServiceLocator 의 역할
		Result result = serviceInvoker.invoke(param);
		
		return result;
	}

}
