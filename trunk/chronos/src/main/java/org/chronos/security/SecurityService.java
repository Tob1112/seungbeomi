package org.chronos.security;

import org.chronos.model.AuthorizationData;

public interface SecurityService {

	public AuthorizationData authenticateUser(AuthorizationData authorizationData);

}
