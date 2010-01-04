package bean;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="PERSON")
public class Person {

	private Integer id;
	private String name;
	private Set<Address> address;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@OneToMany(fetch=FetchType.EAGER)
	@JoinColumn(name="PERSON_ID", nullable=false)
	public Set<Address> getAddress() {
		return address;
	}
	public void setAddress(Set<Address> address) {
		this.address = address;
	}
	/**
		 *
		 * @return
		 * @author
		 */
		public String toString() {
			StringBuffer buffer = new StringBuffer();
			buffer.append("Person[");
			buffer.append(" id = ").append(id);
			buffer.append(" name = ").append(name);
			buffer.append(" address = ").append(address);
			buffer.append("]");
			return buffer.toString();
		}
}
