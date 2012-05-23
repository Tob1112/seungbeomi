package tsb.plus.designpattern.factory;

public class PlusServiceFactory extends PlusFactory {

	@Override
	protected PlusServiceInvoker createServiceInvoker(String serviceType) {
		PlusServiceInvoker serviceInvoker = null;
		
		if ("spring".equals(serviceType)) {
			System.out.println("Factory::PlusSpringServiceInvoker 생성");
			serviceInvoker = new PlusSpringServiceInvoker();
		} else if ("ejb".equals(serviceType)) {
			System.out.println("Factory::PlusEjbServiceInvoker 생성");
			serviceInvoker = new PlusEjbServiceInvoker();
		}
		
		return serviceInvoker;
	}


}
