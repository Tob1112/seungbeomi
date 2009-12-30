package dao;

import java.util.Collection;

import bean.Person;
import org.springframework.dao.DataAccessException;

public interface PersonDao {

    /**
     * Find persons.
     */
    public Collection<Person> findPersons() throws DataAccessException;

    /**
     * Find persons by name.
     */
    public Collection<Person> findPersonsByName(String name) throws DataAccessException;

    /**
     * Saves person.
     */
    public void save(Person person);

}
