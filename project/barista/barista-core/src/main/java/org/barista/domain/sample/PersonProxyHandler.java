package org.barista.domain.sample;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.barista.domain.annotation.Invokable;
import org.barista.domain.annotation.UseInvokable;

public class PersonProxyHandler implements InvocationHandler {

	private static final String EMPTY = "";
	private static final boolean DIRTY = true;

	private DefaultPerson person;
	private PersonDao repository;
	private Map<String, Class<Invokable<PersonProxyHandler>>> inners;
	private boolean loadedId;
	private boolean loadedName;

	public PersonProxyHandler(DefaultPerson person, PersonDao repository) {
		Class<?>[] inners;

		this.person = person;
		this.repository = repository;
		loadedId = false;
		loadedName = false;

		this.inners = new HashMap<String, Class<Invokable<PersonProxyHandler>>>();
		inners = this.getClass().getDeclaredClasses();
		for (int i=0; i < inners.length; i++) {
			this.inners.put(inners[i].getSimpleName(), (Class<Invokable<PersonProxyHandler>>) inners[i]);
		}
	}



	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		String name;
		Object result;
		Class<Invokable<PersonProxyHandler>> inner;
		Constructor<?> constructor;
		UseInvokable useInvokable;
		Invokable<PersonProxyHandler> invokable;

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
			invokable = (Invokable<PersonProxyHandler>) constructor.newInstance(new Object[] {this});

			invokable.invoke(this, proxy, method, args);
		}

		result = method.invoke(this.person, args);

		return result;
	}
/*
	public class GetName implements Invokable<PersonProxyHandler> {
		String loaded;

		@Override
		public void invoke(PersonProxyHandler parent, Object proxy, 
				Method method, Object[] args) throws Throwable {
			//if (!parent.person.isLockedForLazyLoad() && parent.person.isPersisted() && !parent.loadedName) {
			if (!parent.loadedName) {
				loaded = parent.repository.findName(parent.person.getId());
				parent.person.setName(loaded);
				parent.loadedName = true;
			}
		}
	}
*/
}
