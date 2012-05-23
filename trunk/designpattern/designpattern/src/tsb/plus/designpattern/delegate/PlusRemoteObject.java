package tsb.plus.designpattern.delegate;

import tsb.plus.designpattern.factory.PlusFactory;
import tsb.plus.designpattern.factory.PlusServiceFactory;
import tsb.plus.designpattern.factory.PlusServiceInvoker;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusRemoteObject {
	
	private static final String SERVICE_TYPE = "spring";

	public Result execute(Param param) {
		
		PlusFactory factory = new PlusServiceFactory();
		PlusServiceInvoker serviceInvoker = factory.getServiceInvoker(SERVICE_TYPE);
		Result result = serviceInvoker.invoke(param);
		
		return result;
	}
	
}
