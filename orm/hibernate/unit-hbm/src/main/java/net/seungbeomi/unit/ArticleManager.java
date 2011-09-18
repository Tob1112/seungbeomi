package net.seungbeomi.unit;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class ArticleManager {

	@Autowired
	private HibernateDao hibernateDao;

	public Article insertArticle(String title, String content) {
		Article article = new Article();
		article.setTitle(title);
		article.setContent(content);

		hibernateDao.save(article);

		return article;
	}

	public Article updateArticle(Long id, String newTitle, String newContent) {
		Article article = hibernateDao.get(Article.class, id);
		hibernateDao.update(article, newTitle, newContent);

		return article;
	}

	public void deleteArticle(Long id) {
		Article article = hibernateDao.get(Article.class, id);
		hibernateDao.delete(article);
	}

	public Attachment insertAttachment(Long articleId, String filename) {
		Article article = hibernateDao.get(Article.class, articleId);

		Attachment attachment = new Attachment();
		attachment.setFilename(filename);

		hibernateDao.addAttachement(article, attachment);

		return attachment;
	}

	public List<Article> listArticles() {
		return hibernateDao.list(Article.class);
	}
}
