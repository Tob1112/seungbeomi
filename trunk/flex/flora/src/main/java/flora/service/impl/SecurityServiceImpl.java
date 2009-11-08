package flora.service.impl;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.context.support.WebApplicationContextUtils;

import flex.messaging.FlexContext;
import flora.model.User;
import flora.service.SecurityService;

@Service("securityService")
@RemotingDestination
public class SecurityServiceImpl implements SecurityService {

	Log log = LogFactory.getLog(getClass());

	@Override
	public User authenticateUser(String userId, String password) {
		String name;
		Authentication authentication;
    	ApplicationContext context;
    	AuthenticationManager manager;
    	UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userId,password);
    	int authoritiesCount;
    	GrantedAuthority[] authorities;
    	String[] authorizedRoles;

    	context = WebApplicationContextUtils.getWebApplicationContext(FlexContext.getServletConfig().getServletContext());
        manager = (AuthenticationManager) context.getBean("_authenticationManager");
        authentication = manager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        authoritiesCount = authorities.length;

        authorizedRoles = new String[authoritiesCount];

        name = SecurityContextHolder.getContext().getAuthentication().getName();
        for (int counter = 0; counter < authoritiesCount; counter++) {
        	authorizedRoles[counter] = authorities[counter].getAuthority();
        	log.debug(" + Authenticate / user authority : name = " + name + ", authorizedRoles[" + counter + "] = " + authorizedRoles[counter]);
        }

        return new User(authorizedRoles, name);
	}
/*
	@Override
	public User authenticateUser(User user) {
		log.info(" + authenticateUser - userId:" + user.getUserId() + ", pw:" + user.getPassword());
		String name;
		Authentication authentication;
    	ApplicationContext context;
    	AuthenticationManager manager;
    	UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUserId(), user.getPassword());
    	int authoritiesCount;
    	GrantedAuthority[] authorities;
    	String[] authorizedRoles;

    	context = WebApplicationContextUtils.getWebApplicationContext(FlexContext.getServletConfig().getServletContext());
        manager = (AuthenticationManager) context.getBean("_authenticationManager");
        authentication = manager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        authoritiesCount = authorities.length;

        authorizedRoles = new String[authoritiesCount];

        name = SecurityContextHolder.getContext().getAuthentication().getName();
        for (int counter = 0; counter < authoritiesCount; counter++) {
        	authorizedRoles[counter] = authorities[counter].getAuthority();
        	log.debug(" + Authenticate / user authority : name = " + name + ", authorizedRoles[" + counter + "] = " + authorizedRoles[counter]);
        }

        return new User(authorizedRoles, name);
	}
*/

	@Override
	public void test() {
		log.info("+ test test");
	}
}
