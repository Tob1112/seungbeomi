package org.flora.dao.ibatis;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.flora.dao.Dao;
import org.flora.dao.ibatis.model.User;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.util.ClassUtils;

public class BaseDao extends SqlMapClientDaoSupport implements Dao {

	protected final Log log = LogFactory.getLog(getClass());

	@Override
	public List getAll(Class clazz) {
		return getSqlMapClientTemplate().queryForList(getSelectQuery(ClassUtils.getShortName(clazz.toString())));
	}

	@Override
	public Object get(Class clazz, Serializable primaryKey) {
		Object object = getSqlMapClientTemplate().queryForObject(getFindQuery(ClassUtils.getShortName(clazz)), primaryKey);
		if (object == null) {
			log.warn("not found!!");
			throw new ObjectRetrievalFailureException(ClassUtils.getShortName(clazz), primaryKey);
		}
		return object;
	}

	@Override
	public List getRoles(Object object) {
		return getSqlMapClientTemplate().queryForList("getRoles", (User) object);
	}

	@Override
	public boolean exists(Class clazz, Serializable primaryKey) {
		Integer count = (Integer) getSqlMapClientTemplate().queryForObject(getFindQuery(ClassUtils.getShortName(clazz)), primaryKey);
		return count != 0 ? true : false ;
	}

	@Override
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
		if (StringUtils.isBlank(keyId)) {
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

	@Override
	public void remove(Class clazz, Serializable primaryKey) {
		getSqlMapClientTemplate().delete(getDeleteQuery(ClassUtils.getShortName(clazz)), primaryKey);

	}

	// -------------------------------------------- util method

	/**
	 * PK name を使用し、getterメッソドを利用して PKの値を取得
	 *
	 * @param obj
	 * @return primaryKey 値
	 */
	protected Object getPrimaryKeyValue(Object obj) {
		String fieldName = getPrimaryKeyfieldName(obj);
		String getterMethod = "get" + Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);  // make primaryKey getter method

		try {
			Method getMethod = obj.getClass().getMethod(getterMethod, null);
			return getMethod.invoke(obj, null); // getter method を実行
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Could not invoke method '" + getterMethod + "' on " + ClassUtils.getShortName(obj.getClass()));
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

		// PK name に含まれている文字列で検査
		for (Field field :fieldList) {
			if (field.getName().equals("id") || field.getName().indexOf("Id") > -1 || field.getName().equals("version")) {
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
				if (fieldName.equals("version")) {
					Method setMethod = obj.getClass().getMethod("setVersion", new Class[] {Integer.class});
					Object value = obj.getClass().getMethod("getVersion", null).invoke(obj, null);
					if (value == null) {
						setMethod.invoke(obj, new Object[] {new Integer(1)});
					} else {
						setMethod.invoke(obj, new Object[] {new Integer((Integer) value).intValue() + 1});
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Could not prepare '" + ClassUtils.getShortName(obj.getClass()) + "' for insert/update");
		}

	}

	// -------------------------------------------- make query name method

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
        return "delete" + className;
    }

}
