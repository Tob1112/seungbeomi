package tsb.plus.designpattern.delegate;

/**
 * 싱글톤패턴 
 * @author seungbeomi
 */
public class PlusServiceLocator {

	private static PlusServiceLocator instance;
	
	private PlusServiceLocator() {}
	
	public static PlusServiceLocator getInstance() {
		if (instance == null) {
			System.out.println("Delegate::ServiceLocator 객체 생성");
			instance = new PlusServiceLocator();
		}
		return instance;
	}

	public Object getRemoteObject(String remoteObjectClazz) {
		Object remoteObject = null;
		try {
			Class clazz = Class.forName(remoteObjectClazz);
			remoteObject = clazz.newInstance();
			
			System.out.println("Delegate::실행 대상 객체 취득");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return remoteObject;
	}

}
