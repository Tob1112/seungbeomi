package auction.persistence.audit;

import java.sql.Connection;

import org.hibernate.EmptyInterceptor;
import org.hibernate.Session;

import auction.model.Auditable;
import auction.persistence.HibernateUtil;

/**
 * The audit log helper that logs actual events.
 * <p>
 * The <tt>logEvent()</tt> method needs a JDBC connection, it will open a new
 * Hibernate <tt>Session</tt> on that connection and persist the event. The
 * temporary <tt>Session</tt> is then closed, transaction handling is left to
 * the client calling this method.
 * 
 * @author Christian Bauer
 */
public class AuditLog {

	public static void logEvent(String message, Auditable entity, Long userId,
			Connection connection) {

		Session tempSession = HibernateUtil.getSessionFactory().openSession(
				connection, EmptyInterceptor.INSTANCE);

		try {
			AuditLogRecord record = new AuditLogRecord(message, entity.getId(),
					entity.getClass(), userId);

			tempSession.save(record);
			tempSession.flush();

		} finally {
			tempSession.close();
		}
	}
}
