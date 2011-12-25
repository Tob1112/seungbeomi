package seungbeomi.spring.mobile;

import java.security.Principal;

import org.apache.log4j.Logger;
import org.springframework.mobile.device.site.SitePreference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private Logger logger = Logger.getLogger(getClass());
	
	/**
	 * Renders the home page as HTML in thw web browser.
	 * The home page is different based on whether the user is signed in or not.
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(SitePreference sitePreference, Principal user) {
		
		if (sitePreference == SitePreference.MOBILE) {
			logger.debug(">>> sitePreference : " + sitePreference);
		} else {
			logger.debug(">>> sitePreference : " + sitePreference);
		}
		
		return user != null ? "homeSignedIn" : "homeNotSignedIn";
	}
	
}
