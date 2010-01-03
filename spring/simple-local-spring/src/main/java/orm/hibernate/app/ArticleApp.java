package orm.hibernate.app;

import java.util.List;

import orm.hibernate.manager.ArticleManager;
import orm.hibernate.model.Article;
import orm.hibernate.model.Attachment;
import orm.hibernate.util.HibernateUtil;

public class ArticleApp {

	public static void main(String[] args) throws Exception {
		try {
			HibernateUtil.beginTransaction();

			ArticleManager articleManager = new ArticleManager();

			if (args.length == 0) {
				throw new RuntimeException("args is not null!!!");
			}

			if (args[0].equals("IA")) {
				// IA title content
				Article newArticle = articleManager.insertArticle(args[1], args[2]);
				System.out.println(newArticle);
			} else if (args[0].equals("UA")) {
				// UA 1 newTitle newContent
				Article updateArticle = articleManager.updateArticle(new Long(args[1]), args[2], args[3]);
			} else if (args[0].equals("DA")) {
				// DA 1
				articleManager.deleteArticle(new Long(args[1]));
			} else if (args[0].equals("IF")) {
				// IF 1 'filename.txt'
				Attachment attachment = articleManager.insertAttachment(new Long(args[1]), args[2]);
				System.out.println(attachment);
			} else if (args[0].equals("L")) {
				// L
				List<Article> articleList = articleManager.listArticles();
				for (Article article : articleList) {
					System.out.println(article.toString());
				}
			}

			HibernateUtil.commitTransaction();
		} catch (Exception e) {
			HibernateUtil.rollbackTransaction();
			throw e;
		} finally {
			HibernateUtil.closeSession();
		}
	}
}
