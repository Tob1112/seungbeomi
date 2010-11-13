package org.barista.domain;

public interface DomainObject {

	public boolean isPersisted();
	
	public boolean isDirty();
	
	public boolean isDeleted();
	
	public boolean isDisposed();
	
	public boolean isLockedForLazyLoad();
	
	public void dispose();
	
	public void validate() throws Exception;
	
	public void lockForLazyLoad();
	
}
