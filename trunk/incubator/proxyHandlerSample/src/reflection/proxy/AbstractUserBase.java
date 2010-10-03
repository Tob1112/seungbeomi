package reflection.proxy;

public class AbstractUserBase extends AbstractDomainObject implements User{

	private String id;
	private String name;
	private UserType usertype;

	@Override
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public UserType getUserType() {
		return usertype;
	}
	public void setUsertype(UserType usertype) {
		this.usertype = usertype;
	}

}
