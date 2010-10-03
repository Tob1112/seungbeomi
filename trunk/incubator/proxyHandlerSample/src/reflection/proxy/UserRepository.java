package reflection.proxy;

import java.lang.reflect.Proxy;
import java.util.HashMap;
import java.util.Map;

public class UserRepository {

	public String findName(String id) {
		return "seungbeomi";
	}

	public User findUser(String id) {
		Map<String, Object> parameters;
		User found = null;

		if (id.equals("son")) {
			String sqlId = "sqlId";
			parameters = new HashMap<String, Object>();
			found = this.queryForShinseiAnken(sqlId, parameters);
		}

		if (found == null) {
			throw new RuntimeException("Not Found");
		}
		return found;
	}

	private User queryForShinseiAnken(String sqlId,	Map<String, Object> parameters) {
		User found = null;
		try {
			found = dummyUser();
			found = this.wrapByUserProxyHandler(found);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return found;
	}

	private User wrapByUserProxyHandler(User wrappable) {
		Class<?>[] interfaces;
		ClassLoader cl;
		User wrapped;
		UserProxyHandler handler;

		handler = new UserProxyHandler((DefaultUser) wrappable, this);
		interfaces = new Class[] { User.class };
		cl = Thread.currentThread().getContextClassLoader();
		wrapped = (User) Proxy.newProxyInstance(cl, interfaces, handler);

		return wrapped;
	}

	private User dummyUser() {
		DefaultUser user = new DefaultUser();
		user.setId("son");
		//user.setName("seungbeomi");
		return user;
	}

}
