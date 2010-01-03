package orm.hibernate.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class HibernateUtil {

	private static final Log log = LogFactory.getLog(HibernateUtil.class);

	private static SessionFactory sessionFacroty;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFacroty = sessionFactory;
	}
/*
	public static SessionFactory getSessionFactory() {
		return sessionFacroty;
	}
*/
	public static Session getCurrentSession() {
		log.debug("<<< getCurrentSession");
		return sessionFacroty.getCurrentSession();
	}

	public static void closeSession() {
		log.debug("<<< closeSession");
		sessionFacroty.getCurrentSession().close();
	}

	public static Transaction beginTransaction() {
		log.debug("<<< beginTransaction");
		return sessionFacroty.getCurrentSession().beginTransaction();
	}

	public static void commitTransaction() {
		log.debug("<<< commitTransaction");
		sessionFacroty.getCurrentSession().getTransaction().commit();
	}

	public static void rollbackTransaction() {
		log.debug("<<< rollbackTransaction");
		if (sessionFacroty.getCurrentSession().isOpen()) {
			Transaction tx = sessionFacroty.getCurrentSession().getTransaction();
			if (tx != null && tx.isActive()) {
				tx.rollback();
			}
		}
	}
}
