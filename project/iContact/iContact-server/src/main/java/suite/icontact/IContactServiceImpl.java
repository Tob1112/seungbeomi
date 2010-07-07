package suite.icontact;

public class IContactServiceImpl implements IContactService {

	@Override
	public void login(User user) {
		System.out.println("server : username - " + user.getUsername() + ", password - " + user.getPassword());
	}

}
