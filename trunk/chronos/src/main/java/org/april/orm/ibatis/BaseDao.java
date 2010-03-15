package org.april.orm.ibatis;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.util.ClassUtils;

public class BaseDao extends SqlMapClientDaoSupport implements Dao {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	// -------------------------------------------------------
	// OVERRIDE METHODS
	// -------------------------------------------------------

	public List getAll(Class clazz) {
		return getSqlMapClientTemplate().queryForList(getSelectQuery(ClassUtils.getShortName(clazz)));
	}

	public Object get(Class clazz, Serializable primaryKey) {
		Object entity = (Object) getSqlMapClientTemplate().queryForObject(getFindQuery(ClassUtils.getShortName(clazz)), primaryKey);

		if (entity == null) {
			logger.warn("not found!!");
			throw new ObjectRetrievalFailureException(ClassUtils.getShortName(clazz), primaryKey);
		}

		return entity;
	}

	public void save(final Object object) {
		String className = ClassUtils.getShortName(object.getClass());
		Object primaryKey = getPrimaryKeyValue(object);
		String keyId = null;

		// check for null id
		if (primaryKey != null) {
			keyId = primaryKey.toString();
		}

		//check for new record
		// 없는 경우 insert | 있는 경우 update
		if (get(object.getClass(), (Integer) primaryKey) == null) {
			prepareObjectForSaveOrUpdate(object);
			primaryKey = getSqlMapClientTemplate().insert(getInsertQuery(className), object);

			// check for null id
			if (primaryKey == null) {
				keyId = primaryKey.toString();
			}
		} else {
			prepareObjectForSaveOrUpdate(object);
			getSqlMapClientTemplate().update(getUpdateQuery(className), object);
		}

		// check for null id
		if (getPrimaryKeyValue(object) == null) {
			throw new ObjectRetrievalFailureException(className, object);
		}
	}

	public void update(Class clazz) {
		getSqlMapClientTemplate().update(getUpdateQuery(ClassUtils.getShortName(clazz)));
	}

	public void remove(Class clazz, Serializable primaryKey) {
		getSqlMapClientTemplate().delete(getDeleteQuery(ClassUtils.getShortName(clazz)), primaryKey);

	}

	// -------------------------------------------------------
	// UTIL METHODS
	// -------------------------------------------------------
	/**
	 * PK name を使用し、getterメッソドを利用して PKの値を取得
	 *
	 * @param obj
	 * @return primaryKey 値
	 */
	protected Object getPrimaryKeyValue(Object obj) {
		// Use reflection to find the first property that has the name "id" or "Id"
		String fieldName = getPrimaryKeyfieldName(obj);
		String getterMethod = "get" + Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);  // make primaryKey getter method

		try {
			Method getMethod = obj.getClass().getMethod(getterMethod, null);
			return getMethod.invoke(obj, null); // getter method を実行
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Could not invoke method '" + getterMethod + "' on " + ClassUtils.getShortName(obj.getClass()));
		}
		return null;
	}

	/**
	 * 対象オブジェクトのPKフィルドの名前を取得するメソッド
	 *
	 * @param obj
	 * @return primaryKey field name
	 */
	private String getPrimaryKeyfieldName(Object obj) {
		Field fieldList[] = obj.getClass().getDeclaredFields();	// 宣言されたfield list
		String fieldName = null;

		// PK field name に含まれている文字列で検査
		for (Field field :fieldList) {
			if (field.getName().equals("id") || field.getName().indexOf("Id") > -1) {
				fieldName = field.getName();
				break;
			}
		}
		return fieldName;
	}

	/**
	 * 保存または更新を用意 ???
	 *
	 * @param obj
	 */
	protected void prepareObjectForSaveOrUpdate(Object obj) {
		try {
			Field fieldList[] = obj.getClass().getDeclaredFields();
			for (Field field : fieldList) {
				String fieldName = field.getName();

				if (fieldName.equals("id")) {
					Method setMethod = obj.getClass().getMethod("setId", new Class[] {Integer.class});
					Object value = obj.getClass().getMethod("getId", null).invoke(obj, null);
					if (value == null) {
						setMethod.invoke(obj, new Object[] {new Integer(1)});
					} else {
						setMethod.invoke(obj, new Object[] {new Integer((Integer) value).intValue()});
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Could not prepare '" + ClassUtils.getShortName(obj.getClass()) + "' for insert/update");
		}

	}

	// -------------------------------------------------------
	// MAKE QUERY NAME METHOD
	// -------------------------------------------------------
	/** @return Returns the select query name. */
	protected String getSelectQuery(String className) {
		return "get" + className + "s";
	}

	 /** @return Returns the find query name. */
	protected String getFindQuery(String className) {
        return "get" + className;
    }

    /** @return Returns the insert query name. */
	protected String getInsertQuery(String className) {
        return "add" + className;
    }

    /** @return Returns the update query name. */
	protected String getUpdateQuery(String className) {
        return "update" + className;
    }

    /** @return Returns the delete query name. */
	protected String getDeleteQuery(String className) {
        return "remove" + className;
    }
}
