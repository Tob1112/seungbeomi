package com.prms.service;

import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.Set;


import org.apache.commons.collections.CollectionUtils;
import org.aspectj.lang.JoinPoint;
//import org.appfuse.Constants;
//import org.appfuse.model.Role;
//import org.appfuse.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.AccessDeniedException;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationTrustResolver;
import org.springframework.security.AuthenticationTrustResolverImpl;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.dao.UserCache;
import org.springframework.security.userdetails.UserDetails;

import com.prms.Constants;
import com.prms.model.Account;

public class SecurityAspect {

    public final static String ACCESS_DENIED = "Access Denied: Only administrators are allowed to modify other users.";

    protected final Logger logger = LoggerFactory.getLogger(getClass());
    private UserCache userCache;

    public void setUserCache(UserCache userCache) {
        this.userCache = userCache;
    }

    /**
     * Method to enforce security and only allow administrators to modify users. Regular
     * users are allowed to modify themselves.
     */
    public void before(JoinPoint joinPoint) {

    	logger.info("=================================================== start");
    	logger.info("<<< before");

    	Object[] args = joinPoint.getArgs();
    	for (Object arg: args) {
    		logger.info("<<< " + arg.toString());
    	}

        SecurityContext ctx = SecurityContextHolder.getContext();

        if (ctx.getAuthentication() != null) {
            Authentication auth = ctx.getAuthentication();
            boolean administrator = false;
            GrantedAuthority[] roles = auth.getAuthorities();
            for (int i=0; i < roles.length; i++) {
                if (roles[i].getAuthority().equals(Constants.ROLE_ADMIN)) {
                    administrator = true;
                    break;
                }
            }

            Account account = (Account) args[0];
            String username = account.getEmail();
            logger.debug("<<< username = " + username);

            String currentUser;
            if (auth.getPrincipal() instanceof UserDetails) {
                currentUser = ((UserDetails) auth.getPrincipal()).getUsername();
            } else {
                currentUser = String.valueOf(auth.getPrincipal());
            }

            if (username != null && !username.equals(currentUser)) {
                AuthenticationTrustResolver resolver = new AuthenticationTrustResolverImpl();
                // allow new users to signup - this is OK b/c Signup doesn't allow setting of roles
                boolean signupUser = resolver.isAnonymous(auth);
                if (!signupUser) {
                    if (logger.isDebugEnabled()) {
                        logger.debug("Verifying that '" + currentUser + "' can modify '" + username + "'");
                    }
                    if (!administrator) {
                        logger.warn("Access Denied: '" + currentUser + "' tried to modify '" + username + "'!");
                        throw new AccessDeniedException(ACCESS_DENIED);
                    }
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.debug("Registering new account '" + username + "'");
                    }
                }
            }

            // fix for http://issues.appfuse.org/browse/APF-96
            // don't allow users with "user" role to upgrade to "admin" role
            else if (username != null && username.equalsIgnoreCase(currentUser) && !administrator) {

                // get the list of roles the user is trying add
                Set userRoles = new HashSet();
//                if (account.getRoles() != null) {
//                    for (Iterator it = account.getRoles().iterator(); it.hasNext();) {
//                        Role role = (Role) it.next();
//                        userRoles.add(role.getName());
//                    }

//                }

                // get the list of roles the user currently has
                Set authorizedRoles = new HashSet();
                for (int i=0; i < roles.length; i++) {
                    authorizedRoles.add(roles[i].getAuthority());
                }

                // if they don't match - access denied
                // users aren't allowed to change their roles
                if (!CollectionUtils.isEqualCollection(userRoles, authorizedRoles)) {
                    logger.warn("Access Denied: '" + currentUser + "' tried to change their role(s)!");
                    throw new AccessDeniedException(ACCESS_DENIED);
                }
            }
        }
        logger.info("=================================================== end");
    }

    public void afterReturning(JoinPoint joinPoint) {

    	logger.info("<<< after : " + joinPoint.getArgs());

    /*
        User user = (User) args[0];

        if (userCache != null && user.getVersion() != null) {
            if (log.isDebugEnabled()) {
                log.debug("Removing '" + user.getUsername() + "' from userCache");
            }

            userCache.removeUserFromCache(user.getUsername());

            // reset the authentication object if current user
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.getPrincipal() instanceof UserDetails) {
                User currentUser = (User) auth.getPrincipal();
                if (currentUser.getId().equals(user.getId())) {
                    if (!currentUser.getUsername().equalsIgnoreCase(user.getUsername())) {
                        // The name of the current user changed, so the previous flush won't have done anything.
                        // Flush the old name, too.
                        if (log.isDebugEnabled()) {
                            log.debug("Removing '" + currentUser.getUsername() + "' from userCache");
                        }
                        userCache.removeUserFromCache(currentUser.getUsername());
                    }
                    //auth = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(auth);
                }
            }
        }
     */
    }
}
