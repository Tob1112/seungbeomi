package org.april27.security;

import org.april27.model.AuthorizationData;

public interface SecurityService {

	public AuthorizationData authenticateUser(AuthorizationData authorizationData);

}
