package user.model;

import java.sql.SQLException;
import java.util.List;

/**
 * 사용자 관리 API를 사용하는 개발자들이 직접 접근하게 되는 클래스. UserDAO를 이용하여 데이터베이스에 데이터 조작 작업이 가능하도록
 * 하며, 데이터베이스의 데이터들을 이용하여 비지니스 로직을 수행하는 역할을 한다. 비지니스 로직이 복잡한 경우에는 비지니스 로직만을 전담하는
 * 클래스를 별도로 둘 수 있다.
 */
public class UserManager {
	private UserManager() {
	}

	public static UserManager instance() {
		return (new UserManager());
	}

	public int create(User user) throws SQLException, ExistedUserException {
		if (getUserDAO().existedUser(user.getUserId())) {

			throw new ExistedUserException(user.getUserId() + "는 존재하는 아이디입니다.");
		}

		return getUserDAO().create(user);
	}

	public int update(User user) throws SQLException {
		return getUserDAO().update(user);
	}

	public int remove(String userId) throws SQLException {
		return getUserDAO().remove(userId);
	}

	public User findUser(String userId) throws SQLException,
			UserNotFoundException {
		User user = getUserDAO().findUser(userId);

		if (user == null) {
			throw new UserNotFoundException(userId + "는 존재하지 않는 아이디입니다.");
		}

		return user;
	}

	public List findUserList(int currentPage, int countPerPage)
			throws SQLException {
		return getUserDAO().findUserList(currentPage, countPerPage);
	}

	public boolean login(String userId, String password) throws SQLException,
			UserNotFoundException, PasswordMismatchException {

		User user = findUser(userId);

		if (!user.isMatchPassword(password)) {
			throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
		}

		return true;
	}

	private UserDAO getUserDAO() {
		return new UserDAO();
	}
}
