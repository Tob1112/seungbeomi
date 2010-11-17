package org.barista.domain.sample;

import org.barista.domain.DomainObject;
import org.barista.domain.annotation.UseInvokable;

public interface Person extends DomainObject {

	@UseInvokable
	public long getId();
	
	@UseInvokable
	public String getName();
	
}
