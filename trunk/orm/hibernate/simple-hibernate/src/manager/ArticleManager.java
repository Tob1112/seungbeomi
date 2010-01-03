package manager;

import java.util.List;

import model.Article;
import model.Attachment;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;

import util.HibernateUtil;

public class ArticleManager {

	public Article insertArticle(String title, String content) {
		Session session = HibernateUtil.getCurrentSession();

		Article article = new Article();
		article.setTitle(title);
		article.setContent(content);
		session.save(article);

		return article;
	}

	public Article updateArticle(Long id, String newTitle, String newContent) {
		Session session = HibernateUtil.getCurrentSession();

		Article article = (Article) session.get(Article.class, id);
		article.setTitle(newTitle);
		article.setContent(newContent);

		return article;
	}

	public void deleteArticle(Long id) throws Exception {
		Session session = HibernateUtil.getCurrentSession();

		Article article = (Article) session.get(Article.class, id);
		session.delete(article);
	}

	public Attachment insertAttachment(Long articleId, String filename) throws Exception {
		Session session = HibernateUtil.getCurrentSession();

		Article article = (Article) session.get(Article.class, articleId);

		Attachment attachment = new Attachment();
		attachment.setFilename(filename);
		article.addAttachment(attachment);

		return attachment;
	}

	public List<Article> listArticles() {
		Session session = HibernateUtil.getCurrentSession();

		Criteria criteria = session.createCriteria(Article.class);
		criteria.addOrder(Order.asc("id"));

		return criteria.list();
	}
}
