package orm.hibernate.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.orm.hibernate3.HibernateTemplate;

import orm.hibernate.model.Article;
import orm.hibernate.model.Attachment;

public class ArticleDaoImpl implements ArticleDao{

	protected HibernateTemplate template = null;

    public void setSessionFactory(SessionFactory sessionFactory) {
        template = new HibernateTemplate(sessionFactory);
    }

    @Override
    public Article insertArticle(String title, String content) {
    	Article article = new Article();
    	article.setTitle(title);
    	article.setContent(content);
    	template.save(article);
    	return article;
    }

    @Override
    public Article updateArticle(Long id, String newTitle, String newContent) {
    	Article article = (Article) template.get(Article.class, id);
    	article.setTitle(newTitle);
    	article.setContent(newContent);
    	template.saveOrUpdate(article);
    	return article;
    }

	@Override
	public void deleteArticle(Long id) {
		Article article = (Article) template.get(Article.class, id);
		template.delete(article);
	}

	@Override
	public Attachment insertAttachment(Long articleId, String filename) {
		Article article = (Article) template.get(Article.class, articleId);
		Attachment attachment = new Attachment();
		attachment.setFilename(filename);
		article.addAttachment(attachment);
		template.save(attachment);
		return attachment;
	}

	@Override
	public List<Article> listArticles() {
		return template.find("from article");
	}

}
