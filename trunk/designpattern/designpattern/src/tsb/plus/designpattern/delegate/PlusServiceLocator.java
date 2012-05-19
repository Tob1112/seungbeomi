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
			instance = new PlusServiceLocator();
		}
		return instance;
	}

	public Object getRemoteObject(String remoteObjectClazz) {
		Object remoteObject = null;
		try {
			Class clazz = Class.forName(remoteObjectClazz);
			remoteObject = clazz.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return remoteObject;
	}

}
