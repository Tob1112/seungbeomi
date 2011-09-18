package net.seungbeomi.unit;

import java.util.List;

public interface HibernateDao {

	public void save(Article article);

	public Article get(Class<Article> clazz, Long id);

	public void delete(Article article);

	public List<Article> list(Class<Article> clazz);

	public void update(Article article, String newTitle, String newContent);

	public void addAttachement(Article article, Attachment attachment);
}
