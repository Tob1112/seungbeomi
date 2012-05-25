package tsb.plus.designpattern.delegate;

public class PlusServiceLocator {

	private static final String REMOTE_OBJECT = "tsb.plus.designpattern.delegate.PlusBusinessService";
	
	private static PlusServiceLocator instance;
	
	private PlusServiceLocator() {}
	
	public static PlusServiceLocator getInstance() {
		if (instance == null) {
			System.out.println("Delegate::ServiceLocator 생성");
			instance = new PlusServiceLocator();
		}
		return instance;
	}

	public Object getRemoteObject() {
		Object remoteObject = null;
		try {
			Class clazz = Class.forName(REMOTE_OBJECT);
			remoteObject = clazz.newInstance();
			System.out.println("Delegate::실행 객체 취득 : " + remoteObject.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return remoteObject;
	}

}
