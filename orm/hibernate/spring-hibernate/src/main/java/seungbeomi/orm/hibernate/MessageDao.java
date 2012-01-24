package seungbeomi.orm.hibernate;

import java.util.List;

public interface MessageDao {

	public Long save(Message message);

	public List<Message> find();

	public Message get(Class clazz, Long id);
	
}
