package org.seungbeomi.security;

import org.seungbeomi.model.AuthorizationData;
import org.springframework.context.ApplicationContext;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SecurityServiceImpl implements SecurityService {

	@Override
	public AuthorizationData authenticateUser(AuthorizationData authorizationData) {
/*
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
*/
		return null;
	}
}
