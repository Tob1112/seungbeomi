package org.barista.domain.sample;

import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional(readOnly=true)
public class PersonDaoImpl implements PersonDao{
	
	private EntityManager em = null;
	
	@PersistenceContext
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

	@Override
	public Person findPerson(long id) {
		return null;
	}
	
	@Override
	public Collection<DefaultPerson> findPersons() {
		return em.createQuery("select p from Person p").getResultList();
	}
	
	@Override
	public void insert(Person person) {
		
	}
	
	@Override
	public void save(Person person) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void update(long id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		
	}

}
