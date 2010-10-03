package reflection.proxy;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class UserProxyHandler implements InvocationHandler {

	private static final String EMPTY = "";
	private static final boolean DIRTY = true;

	private DefaultUser user;
	private UserRepository userRepository;
	private Map<String, Class<Invokable<UserProxyHandler>>> inners;
	private boolean loadedUserId;
	private boolean loadedName;

	public UserProxyHandler(DefaultUser user, UserRepository userRepository) {
		Class<?>[] inners;

		this.user = user;
		this.userRepository = userRepository;
		loadedUserId = false;
		loadedName = false;

		this.inners = new HashMap<String, Class<Invokable<UserProxyHandler>>>();
		inners = this.getClass().getDeclaredClasses();
		for (int i=0; i < inners.length; i++) {
			this.inners.put(inners[i].getSimpleName(), (Class<Invokable<UserProxyHandler>>) inners[i]);
		}
	}



	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		String name;
		Object result;
		Class<Invokable<UserProxyHandler>> inner;
		Constructor<?> constructor;
		UseInvokable useInvokable;
		Invokable<UserProxyHandler> invokable;

		useInvokable = method.getAnnotation(UseInvokable.class);
		if (useInvokable != null) {
			name = useInvokable.name();
			if (name.equals(EMPTY)) {
				name = method.getName();
				name = (name.length() == 1) ? name.toUpperCase()
						: name.substring(0, 1).toUpperCase() + name.substring(1);
			}

			inner = this.inners.get(name);
			constructor = inner.getConstructor(new Class[] {(this.getClass())});
			invokable = (Invokable<UserProxyHandler>) constructor.newInstance(new Object[] {this});

			invokable.invoke(this, proxy, method, args);
		}

		result = method.invoke(this.user, args);

		return result;
	}

	public class GetName implements Invokable<UserProxyHandler> {

		String loaded;

		@Override
		public void invoke(UserProxyHandler parent, Object proxy, Method method, Object[] args) throws Throwable {
			//if (!parent.user.isLockedForLazyLoad() && parent.user.isPersisted() && !parent.loadedName) {
			if (!parent.loadedName) {
				loaded = parent.userRepository.findName(parent.user.getId());
				parent.user.setName(loaded);
				parent.loadedName = true;
			}


		}

	}

}
