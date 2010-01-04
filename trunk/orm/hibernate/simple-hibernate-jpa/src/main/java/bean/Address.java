package bean;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="ADDRESS")
public class Address {

	private Integer id;
	private String address;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
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
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Address[");
		buffer.append(" id = ").append(id);
		buffer.append(" address = ").append(address);
		buffer.append("]");
		return buffer.toString();
	}
}
