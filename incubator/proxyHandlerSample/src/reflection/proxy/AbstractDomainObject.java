package reflection.proxy;

public abstract class AbstractDomainObject {

	private static final long INITIAL_VERSION = 0;

	private long version;
	private boolean isPersisted;
	private boolean isDirty;
	private boolean isDeleted;
	private boolean isDisposed;
	private boolean isLockedForLazyLoad;

	public AbstractDomainObject() {
		this.version = INITIAL_VERSION;
		this.isPersisted = false;
		this.isDirty = false;
		this.isDeleted = false;
		this.isDisposed = false;
		this.isLockedForLazyLoad = false;
	}

	public AbstractDomainObject(long version) {
		this.version = version;
		this.isPersisted = false;
		this.isDirty = false;
		this.isDeleted = false;
		this.isDisposed = false;
		this.isLockedForLazyLoad = false;
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

	public boolean isPersisted() {
		return isPersisted;
	}

	public void setPersisted(boolean isPersisted) {
		this.isPersisted = isPersisted;
	}

	public boolean isDirty() {
		return isDirty;
	}

	public void setDirty(boolean isDirty) {
		this.isDirty = isDirty;
	}

	public void delete() {
		this.isDeleted = true;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public void dispose() {
		this.isDisposed = true;
	}

	public boolean isDisposed() {
		return isDisposed;
	}

	public void setDisposed(boolean isDisposed) {
		this.isDisposed = isDisposed;
	}

	public void lockForLazyLoad() {
		this.isLockedForLazyLoad = true;
	}

	public boolean isLockedForLazyLoad() {
		return isLockedForLazyLoad;
	}

	public void setLockedForLazyLoad(boolean isLockedForLazyLoad) {
		this.isLockedForLazyLoad = isLockedForLazyLoad;
	}

	public void validate() {}

}
