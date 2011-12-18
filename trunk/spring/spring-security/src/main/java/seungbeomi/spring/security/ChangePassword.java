package seungbeomi.spring.security;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface ChangePassword extends UserDetailsService {

	void changePassword(String username, String password);
	
}
