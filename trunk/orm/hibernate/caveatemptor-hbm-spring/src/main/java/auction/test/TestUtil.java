package auction.test;

import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.tool.hbm2ddl.SchemaExport;

import auction.persistence.HibernateUtil;

/**
 * Some helper methods useful during testing.
 * 
 * @author Christian Bauer
 */
public class TestUtil {

	public static String getSessionContextConfigurationSetting() {
		return HibernateUtil.getConfiguration().getProperty(
				Environment.CURRENT_SESSION_CONTEXT_CLASS);
	}

	public static void enableSessionContext(
			String currentSessionContextClassName) {
		HibernateUtil.getConfiguration().setProperty(
				Environment.CURRENT_SESSION_CONTEXT_CLASS,
				currentSessionContextClassName);
		HibernateUtil.rebuildSessionFactory();
	}

	public static void recreateDatabase(Configuration cfg) {
		SchemaExport schemaExport = new SchemaExport(cfg);
		schemaExport.drop(false, true);
		schemaExport.create(false, true);
	}

}
