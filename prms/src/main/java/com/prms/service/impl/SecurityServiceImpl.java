package com.prms.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationManager;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.prms.dao.SecurityDao;
import com.prms.model.Account;
import com.prms.model.Message;
import com.prms.service.SecurityService;
import com.prms.util.Md5Encrypt;
import com.prms.util.MessageUtil;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

/**
 * @author 孫承範
 */
public class SecurityServiceImpl implements SecurityService{

	private final Logger logger = LoggerFactory.getLogger(getClass());

	FlexSession session = null;
	private SecurityDao securityDao;


	public void setSecurityDao(SecurityDao securityDao) {
		this.securityDao = securityDao;
	}

	/**
	 *
	 * @see com.prms.login.business.service.iface.SecurityLoginService#authenticateUser(com.prms.account.business.domain.Account)
	 */
	@Override
	public Account authenticateUser(Account account) {
		String md5EncryptedPasswd = new Md5Encrypt().encryptingPassword((account.getPasswd()));
		logger.debug("<<< md5EncryptedPasswd - " + md5EncryptedPasswd);
		UsernamePasswordAuthenticationToken token
			= new UsernamePasswordAuthenticationToken(account.getEmail(), md5EncryptedPasswd);

		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(FlexContext.getServletConfig().getServletContext());
		AuthenticationManager manager = (AuthenticationManager) context.getBean("_authenticationManager");
		Authentication authentication = manager.authenticate(token);
		SecurityContextHolder.getContext().setAuthentication(authentication);
		GrantedAuthority[] grantedAuthorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		int rolesCount = grantedAuthorities.length;
		String[] roles = new String[rolesCount];

		String email = SecurityContextHolder.getContext().getAuthentication().getName();
		for (int counter = 0; counter < rolesCount; counter++) {
			roles[counter] = grantedAuthorities[counter].getAuthority();
		}

		Account bean = createSession(email);
		bean.setEmail(email);
		bean.setRoles(roles);

		return bean;
	}

	public Account createSession(String email) {

         if( getSession(email) == null) {
                 session = FlexContext.getFlexSession();
                 session.setAttribute("account", securityDao.getAccountByEmail(email));
         } else {
                 logger.debug(" <<< exist session!!");
         }
         return (Account) session.getAttribute("account");
	 }

	public Account getSession(String email) {
         session = FlexContext.getFlexSession();
         return  (Account) session.getAttribute(email);
	 }

	/**
	 * @see com.prms.login.business.service.iface.SecurityLoginService#logout(java.lang.String)
	 */
	@Override
	public Message logout(String empNo) {
		SecurityContextHolder.getContext().setAuthentication(null);
		FlexContext.getFlexSession().invalidate();
		return MessageUtil.getMessage("I", "0001");
	}

}
