package org.april.security;

import org.april.model.AuthorizationData;

public interface SecurityService {

	public AuthorizationData authenticateUser(AuthorizationData authorizationData);

}
