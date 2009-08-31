package seungbeomi.user.mvc;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import seungbeomi.user.ibatis.dao.UserDao;
import seungbeomi.user.model.User;

@Controller
public class UserController {

	Logger logger = LoggerFactory.getLogger(UserController.class);

	private static final String SEARCH_VIEW_KEY = "redirect:search.html";
    private static final String SEARCH_MODEL_KEY = "users";

	@Autowired
	protected UserDao userDao = null;

	@ModelAttribute
	public User newRequest(@RequestParam(required=false) String userId) {
		logger.info("newRequest() userId = " + userId);

		User user = userDao.findUserByUserId(userId);

		return (user != null ? user : new User());
	}

	@RequestMapping(method=RequestMethod.GET)
	public void form(){}

	@RequestMapping(method=RequestMethod.POST)
	public void form(User user, Model model){
		Assert.notNull(user, "Form user is null.");

		if(userDao.findUserByUserId(user.getUserId()) == null){
			userDao.create(user);
		} else {
			userDao.update(user);
		}

		model.addAttribute("statusMessageKey", "user.form.msg.success");
	}

	@RequestMapping(method=RequestMethod.POST)
	public String delete(User user) {
		Assert.notNull(user, "Delete User is null.");

		userDao.delete(user.getUserId());

		return SEARCH_VIEW_KEY;
	}

	@RequestMapping(method=RequestMethod.GET)
	public @ModelAttribute(SEARCH_MODEL_KEY) Collection<User> search() {
		return userDao.findUsers();
	}
}
