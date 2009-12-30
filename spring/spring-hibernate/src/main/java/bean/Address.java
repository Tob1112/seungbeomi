package bean;

import java.util.Date;

public class Address {

    private Integer id = null;
    private String address = null;
    private Date created = null;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}

	@Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.getClass().getName() + "-");
        sb.append("  id=" + id);
        sb.append("  addresss=" + address);
        sb.append("  created=" + created);
        return sb.toString();
    }

    /**
     * Returns a hash code value for the object.
     */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + ((created == null) ? 0 : created.hashCode());
		return result;
	}

	/**
	 * Indicates whether some other object is equal to this one.
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Address other = (Address) obj;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (created == null) {
			if (other.created != null)
				return false;
		} else if (!created.equals(other.created))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
