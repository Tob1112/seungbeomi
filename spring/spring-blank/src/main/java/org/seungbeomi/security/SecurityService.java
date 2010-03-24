package org.seungbeomi.security;

import org.seungbeomi.model.AuthorizationData;

public interface SecurityService {

	public AuthorizationData authenticateUser(AuthorizationData authorizationData);

}
