package seungbeomi.orm.hibernate;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class MessageDaoImpl extends HibernateDaoSupport implements MessageDao {

	public Long save(Message message) {
		return (Long) getHibernateTemplate().save(message);
	}

	public List<Message> find() {
		return getHibernateTemplate()
				.find("from Message m order by m.text asc");
	}

	public Message get(Class clazz, Long id) {
		return getHibernateTemplate().get(clazz, id);
	}
}
