package reflection.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public interface Invokable<T extends InvocationHandler> {
	public void invoke(T parent, Object proxy, Method method, Object[] args) throws Throwable;
}
