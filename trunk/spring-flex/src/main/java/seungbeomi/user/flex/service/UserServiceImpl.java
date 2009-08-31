package seungbeomi.user.flex.service;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.context.support.WebApplicationContextUtils;

import seungbeomi.user.ibatis.dao.UserDao;
import seungbeomi.user.model.User;
import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

@Service("userService")
@RemotingDestination
public class UserServiceImpl implements UserService {

	Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	private Authentication authentication;

	private UserDao userDao;

	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	// login
	public User authenticateUser(String userId, String password) {
		String id;
    	ApplicationContext appContext;
    	AuthenticationManager manager;
    	UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userId,password);
    	token.setDetails(userId);
    	int numAuthorities;
    	GrantedAuthority[] authorities;
    	String[] authorizedGroups;

    	appContext = WebApplicationContextUtils.getWebApplicationContext(FlexContext.getServletConfig().getServletContext());
        manager = (AuthenticationManager)appContext.getBean("_authenticationManager");
        authentication = manager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        numAuthorities = authorities.length;

        authorizedGroups = new String[numAuthorities];

        id = SecurityContextHolder.getContext().getAuthentication().getName();
        for (int counter = 0; counter < numAuthorities; counter++) {
        	authorizedGroups[counter] = authorities[counter].getAuthority();
        	logger.debug(" <<< Authenticate / user authority : id = " + id + ", authorizedGroups[" + counter + "] = " + authorizedGroups[counter]);
        }

        return new User(authorizedGroups, id);
	}

	public Collection<User> findUsers() {
		SecurityContextHolder.getContext().setAuthentication(authentication);

		return userDao.findUsers();
	}

	public User findUserByUserIdAndPassword(String userId, String password) {
		return userDao.findUserByUserIdAndPassword(userId, password);
	}

	public User findUserByUserId(String userId) {
		SecurityContextHolder.getContext().setAuthentication(authentication);

		return userDao.findUserByUserId(userId);
	}

	// Session
	public void createSession(String userId) {
		logger.debug(" <<< create session : userId = " + userId);

		if( getSession(userId) == null) {
			FlexSession session = FlexContext.getFlexSession();
			session.setAttribute("userId", userId);
		} else {
			logger.debug(" <<< exist session!!");
		}
	}

	public String getSession(String userId) {
		FlexSession session = FlexContext.getFlexSession();
		return  (String) session.getAttribute(userId);
	}

	public void removeSession() {
		logger.debug(" <<< remove session");
		FlexSession session = FlexContext.getFlexSession();
		session.invalidate();

		//spring security logout
		SecurityContextHolder.getContext().setAuthentication(null);
	}
}