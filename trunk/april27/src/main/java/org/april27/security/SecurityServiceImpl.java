package org.april27.security;

import org.april27.model.AuthorizationData;
import org.springframework.context.ApplicationContext;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.web.context.support.WebApplicationContextUtils;

import flex.messaging.FlexContext;

public class SecurityServiceImpl implements SecurityService {

	@Override
	public AuthorizationData authenticateUser(AuthorizationData authorizationData) {
		/*
		GrantedAuthority[] authorities =
			SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		int numAuthorities = authorities.length;
		String[] grantedRoles = new String[numAuthorities];
		for (int i = 0; i < numAuthorities; i++) {
			grantedRoles[i] = authorities[i].getAuthority();
		}
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		return new Authentication(username, grantedRoles);
		*/
		UsernamePasswordAuthenticationToken token =
			new UsernamePasswordAuthenticationToken(authorizationData.getUsername(), authorizationData.getPassword());

		ApplicationContext context =
			WebApplicationContextUtils.getWebApplicationContext(FlexContext.getServletConfig().getServletContext());
		AuthenticationManager manager =
			(AuthenticationManager) context.getBean("_authenticationManager");
		Authentication authentication = manager.authenticate(token);
		SecurityContextHolder.getContext().setAuthentication(authentication);
		GrantedAuthority[] grantedAuthorities =
			SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		int rolesCount = grantedAuthorities.length;
		String[] grantedRoles = new String[rolesCount];

		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		for (int i = 0; i < rolesCount; i++) {
			grantedRoles[i] = grantedAuthorities[i].getAuthority();
		}
		return new AuthorizationData(username, grantedRoles);
	}
}
