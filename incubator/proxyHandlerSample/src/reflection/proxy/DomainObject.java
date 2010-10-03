package reflection.proxy;

public interface DomainObject {

	public boolean isPersisted();

	public boolean isDirty();

	public boolean isDeleted();

	public void validate() throws Exception;

	public boolean isDisposed();

	public void dispose();

	public void lockForLazyLoad();

	public boolean isLockedForLazyLoad();
}
