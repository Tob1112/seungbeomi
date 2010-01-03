package orm.hibernate.dao;

import java.util.List;

import orm.hibernate.model.Article;
import orm.hibernate.model.Attachment;

public interface ArticleDao {

	public Article insertArticle(String title, String content);

	public Article updateArticle(Long id, String newTitle, String newContent);

	public void deleteArticle(Long id);

	public Attachment insertAttachment(Long articleId, String filename);

	public List<Article> listArticles();

}
