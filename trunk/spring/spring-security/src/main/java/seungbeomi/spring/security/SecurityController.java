package seungbeomi.spring.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SecurityController {
	
	@Autowired
	private JdbcUserDetailsManager jdbcUserService;

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index() {
		return "index";
	}
	
	@RequestMapping(value="/login.do")
	public String login() {
		return "views/login";
	}
	
	@RequestMapping(value="/loginSuccess.do")
	public String loginSuccess() {
		return "views/secure/index";
	}
	
	@RequestMapping(value="/secure/menu.do")
	public String menu() {
		return "views/secure/menu";
	}
	
	@RequestMapping(value="/secure/admin.do")
	public String admin() {
		return "views/secure/admin";
	}
	
	@RequestMapping(value="/secure/changePassword.do", method=RequestMethod.GET)
	public String showChangePassword() {
		return "views/secure/changePassword";
	}
	
	/**
	 * 비밀번호를 변경한다.
	 * @param newPassword
	 * @return
	 */
	@RequestMapping(value="/secure/changePassword.do", method=RequestMethod.POST)
	public String submitChangePassword(@RequestParam("password") String newPassword) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = principal.toString();
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		}
		jdbcUserService.changePassword(username, newPassword);
		SecurityContextHolder.clearContext();
		return "redirect:/";
	}
	
}
