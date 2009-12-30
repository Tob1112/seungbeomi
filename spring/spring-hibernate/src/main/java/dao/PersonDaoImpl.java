package dao;


import java.util.Collection;

import org.hibernate.SessionFactory;
import bean.Person;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional(readOnly = true)
public class PersonDaoImpl implements PersonDao {

    protected HibernateTemplate template = null;

    /**
     * Sets Hibernate session factory.
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        template = new HibernateTemplate(sessionFactory);
    }

    /**
     * Find persons.
     */
    @SuppressWarnings("unchecked")
    public Collection<Person> findPersons() throws DataAccessException {
        return template.find("from Person");
    }

    /**
     * Find persons by last name.
     */
    @SuppressWarnings("unchecked")
    public Collection<Person> findPersonsByName(String name) throws DataAccessException {
        return template.find("from Person p where p.lastName = ?", name);
    }

    /**
     * Saves person.
     */
    @Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
    public void save(Person person) {
        template.saveOrUpdate(person);
    }

}
