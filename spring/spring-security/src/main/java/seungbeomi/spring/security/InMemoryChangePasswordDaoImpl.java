package seungbeomi.spring.security;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.memory.InMemoryDaoImpl;

//@Repository("changePasswordDao")
public class InMemoryChangePasswordDaoImpl extends InMemoryDaoImpl implements
		ChangePassword {

	public void changePassword(String username, String password) {
		// UserDetails 를 가져온다.
		User userDetails = (User) getUserMap().getUser(username);
		// 새로운 비밀번호를 사용해 새로운 UserDetails 를 생성한다.
		User newUserDetails = new User(
				userDetails.getUsername(), 
				password,
				userDetails.isEnabled(),
				userDetails.isAccountNonExpired(),
				userDetails.isCredentialsNonExpired(),
				userDetails.isAccountNonLocked(),
				userDetails.getAuthorities());
		// 맵에 추가한다.
		getUserMap().addUser(newUserDetails);

	}

}
