package orm.hibernate.app;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import orm.hibernate.dao.ArticleDao;
import orm.hibernate.model.Article;
import orm.hibernate.model.Attachment;

public class ArticleApp {

	public static void main(String[] args) throws Exception {

		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ArticleDao articleDao = (ArticleDao) context.getBean("articleDao");

		if (args.length == 0) {
			throw new RuntimeException("args is not null!!!");
		}

		if (args[0].equals("IA")) {
			// IA title content
			Article newArticle = articleDao.insertArticle(args[1], args[2]);
			System.out.println(newArticle);
		} else if (args[0].equals("UA")) {
			// UA 1 newTitle newContent
			Article updateArticle = articleDao.updateArticle(new Long(
					args[1]), args[2], args[3]);
		} else if (args[0].equals("DA")) {
			// DA 1
			articleDao.deleteArticle(new Long(args[1]));
		} else if (args[0].equals("IF")) {
			// IF 1 'filename.txt'
			Attachment attachment = articleDao.insertAttachment(new Long(
					args[1]), args[2]);
			System.out.println(attachment);
		} else if (args[0].equals("L")) {
			// L
			List<Article> articleList = articleDao.listArticles();
			for (Article article : articleList) {
				System.out.println(article.toString());
			}
		}

	}
}
