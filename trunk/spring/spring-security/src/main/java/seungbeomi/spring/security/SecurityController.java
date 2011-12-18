package seungbeomi.spring.security;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SecurityController {

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index() {
		return "views/login";
	}
	
	@RequestMapping(value="/login.do")
	public String login() {
		return "views/secure/index";
	}
}
