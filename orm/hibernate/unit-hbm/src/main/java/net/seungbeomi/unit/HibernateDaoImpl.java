package net.seungbeomi.unit;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class HibernateDaoImpl extends HibernateDaoSupport implements
		HibernateDao {

	public void save(Article article) {
		getHibernateTemplate().save(article);
	}

	public Article get(Class<Article> clazz, Long id) {
		return getHibernateTemplate().get(clazz, id);
	}

	public void delete(Article article) {
		getHibernateTemplate().delete(article);
	}

	public List<Article> list(Class<Article> clazz) {
		Criteria criteria = getSession().createCriteria(clazz);
		criteria.addOrder(Order.asc("id"));
		return criteria.list();
	}

	public void update(Article article, String newTitle, String newContent) {
		article.setTitle(newTitle);
		article.setContent(newContent);
	}

	public void addAttachement(Article article, Attachment attachment) {
		article.addAttachment(attachment);
	}

}
