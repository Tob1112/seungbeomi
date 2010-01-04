package dao;

import java.util.Collection;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

import bean.Person;

public class PersonDaoImpl implements PersonDao{

	protected HibernateTemplate template = null;

	public void setSessionFactory(SessionFactory sessionFactory) {
        template = new HibernateTemplate(sessionFactory);
    }

	@Override
	public Collection<Person> getPersonList() {
		return template.find("from Person");
	}

}
