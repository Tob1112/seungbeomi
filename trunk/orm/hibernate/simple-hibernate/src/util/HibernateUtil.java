package util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

	private static final Log log = LogFactory.getLog(HibernateUtil.class);

	private static final SessionFactory sf;

	static {
		try {
			sf = new Configuration().configure().buildSessionFactory();
		} catch (Throwable e) {
			log.fatal("fail to initialize Hibernate SessionFactory", e);
			throw new ExceptionInInitializerError(e);
		}
	}

	public static SessionFactory getSessionFactory() {
		return sf;
	}

	public static Session getCurrentSession() {
		return sf.getCurrentSession();
	}

	public static void closeSession() {
		sf.getCurrentSession().close();
	}

	public static Transaction beginTransaction() {
		return sf.getCurrentSession().beginTransaction();
	}

	public static void commitTransaction() {
		sf.getCurrentSession().getTransaction().commit();
	}

	public static void rollbackTransaction() {
		if (sf.getCurrentSession().isOpen()) {
			Transaction tx = sf.getCurrentSession().getTransaction();
			if (tx != null && tx.isActive()) {
				tx.rollback();
			}
		}
	}
}
