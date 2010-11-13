package org.barista.common.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

import org.barista.exception.BaristaRuntimeException;
import org.barista.common.message.BaristaMessages;
import org.barista.common.message.MessageId;

public class SystemPropertyImpl implements SystemProperty {

	private static final Logger log = Logger.getLogger(SystemPropertyImpl.class.getName());

	private static final String SYSTEM_PROPERTY_FILE_NAME = "SystemProperty.properties";

	private static final String JDBC_DRIVER_CLASS_NAME          = "jdbc.driverclassname";
	private static final String JDBC_URL                        = "jdbc.url";
	private static final String JDBC_USER                       = "jdbc.user";
	private static final String JDBC_PASSWORD                   = "jdbc.password";
	private static final String DB_SYSTEM_PROPERTY_TABLE_NAME   = "systemproperty.tablename";
	private static final String DB_KEY_TABLE_NAME               = "systemproperty.keytablename";
	private static final String DB_KEY_DATA_COLUMN_NAME         = "systemproperty.keydatacolumnname";
	private static final String DB_SECRET_KEY                   = "systemproperty.secretkey";

	enum Status { READY, NOT_READY, LOADING; }

	/** システムポロパティを保存するキャッシュ */
	private static Map<String, String> cache = new HashMap<String, String>();
	/** キャッシュの状態 */
	private static Status state = Status.NOT_READY;

	private static String url;
	private static String user;
	private static String password;
	private static String systemPropertyTableName;
	private static String keyTableName;
	private static String keyDataColumnName;
	private static String secretKey;

	private static final int SLEEP_TIME = 1000;

	private static final SystemPropertyImpl INSTANCE = new SystemPropertyImpl();

	private SystemPropertyImpl() {
		state = Status.NOT_READY;
		ClassLoader cl = null;
		InputStream in = null;
		Properties prop = new Properties();

		try {
			cl = Thread.currentThread().getContextClassLoader();
			in = cl.getResourceAsStream(SYSTEM_PROPERTY_FILE_NAME);
			prop.load(in);
		} catch (FileNotFoundException e) {
			throw new BaristaRuntimeException(MessageId.FILE_NOT_FOUND, BaristaMessages.getMessage(MessageId.FILE_NOT_FOUND));
		} catch (IOException e) {
			throw new BaristaRuntimeException(MessageId.IO_EXCEPTION, BaristaMessages.getMessage(MessageId.IO_EXCEPTION));
		}

		url = prop.getProperty(JDBC_URL);
		user = prop.getProperty(JDBC_USER);
		password = prop.getProperty(JDBC_PASSWORD);
		systemPropertyTableName = prop.getProperty(DB_SYSTEM_PROPERTY_TABLE_NAME);
		keyTableName = prop.getProperty(DB_KEY_TABLE_NAME);
		keyDataColumnName = prop.getProperty(DB_KEY_DATA_COLUMN_NAME);
		secretKey = prop.getProperty(DB_SECRET_KEY);

		state = Status.LOADING;

		try {
			readProperty();
			state = Status.READY;
		} catch (Exception e) {
			state = Status.NOT_READY;
			log.fine("システムプロパティ取得失敗" + e);
			throw new BaristaRuntimeException(e.getMessage());
		}
	}

	public static SystemProperty getInstance() {
		return INSTANCE;
	}

	private static boolean isReady() {
		return state == Status.READY;
	}

	private boolean isLoading() {
		return state == Status.LOADING;
	}

	private static void setStatus(Status status) {
		state = status;
	}

	@Override
	public String getProperty(String key) {
		String property = null;
		while (isLoading()) {
			try {
				Thread.sleep(SLEEP_TIME );
			} catch (InterruptedException e) {
				throw new BaristaRuntimeException(e);
			}
		}
		if (isReady()) {
			property = (String) cache.get(key);
		} else {
			throw new BaristaRuntimeException();
		}

		if (property == null || property.isEmpty()) {
			throw new BaristaRuntimeException();
		}

		return property;
	}

	@Override
	public synchronized void reset() {
		setStatus(Status.LOADING);
		cache.clear();
		try {
			readProperty();
		} catch (Exception e) {
			throw new BaristaRuntimeException(e);
		}
		setStatus(Status.READY);
	}

	private void readProperty() throws SQLException, ClassNotFoundException{
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		CallableStatement cs = null;

		try {
			Class.forName(JDBC_DRIVER_CLASS_NAME);
			con = DriverManager.getConnection(url, user, password);

			try {
				stmt = con.createStatement();
				rs = stmt.executeQuery(getObtainPropertySql());
				while (rs.next()) {
					cache.put(rs.getString(1), rs.getString(2));
					log.fine(rs.getString(1) + "¥t" +  rs.getString(2));
				}
			} finally {
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
			}

			String keyName = "privateKey";
			cs = con.prepareCall(getObtainPropertySql(keyName));
			cs.registerOutParameter(1, Types.VARCHAR);
			cs.execute();
			cache.put(keyName, cs.getString(1));
			cs.close();
		} finally {
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
			if (rs != null) {
				rs.close();
				rs = null;
			}
		}
	}

	private String getObtainPropertySql() {
		return "SELECT * FROM " + systemPropertyTableName;
	}

	private String getObtainPropertySql(String keyName) {
		return "";
	}
}
