package com.chronos.web.sample;

import java.util.List;

import com.chronos.domain.sample.Person;
import com.chronos.domain.sample.PersonService;
import com.opensymphony.xwork2.ActionSupport;

public class PersonAction extends ActionSupport {

	private PersonService personService;
	private List<Person> people;

	public String execute() throws Exception {
		people = personService.list();
		return SUCCESS;
	}

	//-----------------------------------------------
	public PersonService getPersonService() {
		return personService;
	}

	public void setPersonService(PersonService personService) {
		this.personService = personService;
	}

	public List<Person> getPeople() {
		return people;
	}

	public void setPeople(List<Person> people) {
		this.people = people;
	}

}
