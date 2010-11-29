package org.chronos.domain.sample;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//@Service("PersonService")
public class PersonServiceImpl implements PersonService{

	@Autowired
	private PersonDao dao;

	@Override
	public List<Person> list() {
		return dao.list();
	}

	@Override
	public Person get(int id) {
		return dao.get(id);
	}

	@Override
	public void add(Person person) {
		dao.add(person);
	}

	@Override
	public void update(Person person) {
		dao.update(person);
	}

	@Override
	public void delete(int id) {
		dao.delete(id);
	}
}
