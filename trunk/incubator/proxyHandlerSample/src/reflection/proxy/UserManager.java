package reflection.proxy;

public interface UserManager extends UserEnum {

	@UseInvokable
	public String getUserId();

	@UseInvokable
	public String getName();
}
