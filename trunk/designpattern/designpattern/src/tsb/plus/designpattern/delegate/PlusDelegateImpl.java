package tsb.plus.designpattern.delegate;

import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;

public class PlusDelegateImpl implements PlusDelegate {

	private PlusServiceLocator serviceLocator;
	private PlusBusinessService service;
	
	public PlusDelegateImpl() {
		if (serviceLocator == null) {
			serviceLocator = PlusServiceLocator.getInstance();
		}
		service = (PlusBusinessService) serviceLocator.getRemoteObject();
	}
	
	@Override
	public Result send(Param param) {
		System.out.println("Delegate::Delegate 메소드 실행");
		return service.execute(param);
	}

}
