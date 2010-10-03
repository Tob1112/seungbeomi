package reflection.proxy;

public interface User extends DomainObject, UserEnum {

	@UseInvokable
	public String getId();

	@UseInvokable
	public String getName();

	@UseInvokable
	public UserType getUserType();
}
