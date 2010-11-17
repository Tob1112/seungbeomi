package org.barista.domain.sample;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.barista.domain.AbstractDomainObject;

@Entity(name="Person")
@Table(name="Person")
public class DefaultPerson extends AbstractDomainObject implements Person {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(nullable=false, length=10, unique=true)
	private long id;
	@Column(nullable=false, length=50)
	private String name;
	
	public void setId(long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public long getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
}
