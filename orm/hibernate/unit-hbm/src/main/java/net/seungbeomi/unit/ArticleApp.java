package net.seungbeomi.unit;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ArticleApp {

	private static ArticleManager articleManager;

	public static void main(String[] args) {

		if (articleManager == null) {
			ApplicationContext context = new ClassPathXmlApplicationContext(
					"classpath:META-INF/spring/app-context.xml");
			articleManager = (ArticleManager) context.getBean("articleManager");
		}

		String op = args[0];

		if ("IA".equals(op)) {
			Article newArticle = articleManager.insertArticle(args[1], args[2]);
			System.out.println(">>> result : " + newArticle);
		} else if ("UA".equals(op)) {
			Article updateArticle = articleManager.updateArticle(new Long(
					args[1]), args[2], args[3]);
			System.out.println(">>> result : " + updateArticle);
		} else if ("DA".equals(op)) {
			articleManager.deleteArticle(new Long(args[1]));
		} else if ("IF".equals(op)) {
			Attachment attachment = articleManager.insertAttachment(new Long(
					args[1]), args[2]);
			System.out.println(">>> result : " + attachment);
		} else if ("L".equals(op)) {
			List<Article> articles = articleManager.listArticles();
			for (Article article : articles) {
				System.out.println(">>> result : " + article);
			}
		}
	}
}
