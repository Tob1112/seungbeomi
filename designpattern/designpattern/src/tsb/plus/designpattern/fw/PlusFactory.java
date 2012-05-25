package tsb.plus.designpattern.fw;

public abstract class PlusFactory {

	// 변하지 않는 부분 :: 구현
	public PlusServiceInvoker getServiceInvoker(String serviceType) {
		PlusServiceInvoker plusServiceInvoker = createServiceInvoker(serviceType);
		return plusServiceInvoker;
	}
	
	// 변하는 부분 => 서브클래스에 위임
	protected abstract PlusServiceInvoker createServiceInvoker(String serviceType);
	
}
