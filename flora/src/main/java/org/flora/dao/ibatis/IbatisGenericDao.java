package org.flora.dao.ibatis;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

import org.flora.dao.GenericDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.util.ClassUtils;

public class IbatisGenericDao<T, PK extends Serializable> extends SqlMapClientDaoSupport implements GenericDao<T, PK> {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<T> getAll(T object) {
		return getSqlMapClientTemplate().queryForList(getSelectListQuery(ClassUtils.getShortName(object.getClass())));
	}

	@Override
	public T get(T object, PK id) {
		T entity = (T) getSqlMapClientTemplate().queryForObject(getSelectQuery(ClassUtils.getShortName(object.getClass())), id);
		if (entity == null) {
			logger.warn("not found!!");
			throw new ObjectRetrievalFailureException(ClassUtils.getShortName(object.getClass()), id);
		}
		return entity;
	}

	@Override
	public List<T> find(T object, T parameterObject) {
		return getSqlMapClientTemplate().queryForList(getFindQuery(ClassUtils.getShortName(object.getClass())), parameterObject);
	}

	@Override
	public List<T> getRoles(T object) {
		return getSqlMapClientTemplate().queryForList("getRoles", (T) object);
	}

	@Override
	public boolean exists(T object, PK id) {
		Integer count = (Integer) getSqlMapClientTemplate().queryForObject(getExistsQuery(ClassUtils.getShortName(object.getClass())), id);
		return count != 0 ? true : false ;
	}

	@Override
	public void save(final T object) {
		String className = ClassUtils.getShortName(object.getClass());
		Object primaryKey = getPrimaryKeyValue(object);
		String keyId = null;

		// check for null id
		if (primaryKey != null) {
			keyId = primaryKey.toString();
		}

		//check for new record
		// 없는 경우 insert | 있는 경우 update
		//if (StringUtils.isBlank(keyId)) {
		Integer exists = (Integer) getSqlMapClientTemplate().queryForObject(getExistsQuery(ClassUtils.getShortName(object.getClass())), Integer.parseInt(keyId));

		if (exists == 0) {
			prepareObjectForSaveOrUpdate(object);
			logger.debug("execute save - " + getInsertQuery(className));
			primaryKey = getSqlMapClientTemplate().insert(getInsertQuery(className), object);

			// check for null id
			if (primaryKey == null) {
				keyId = primaryKey.toString();
			}
		} else {
			prepareObjectForSaveOrUpdate(object);
			logger.debug("execute save - " + getUpdateQuery(className));
			getSqlMapClientTemplate().update(getUpdateQuery(className), object);
		}

		// check for null id
		if (getPrimaryKeyValue(object) == null) {
			throw new ObjectRetrievalFailureException(className, object);
		}
	}

	@Override
	public void remove(T object, PK id) {
		getSqlMapClientTemplate().delete(getDeleteQuery(ClassUtils.getShortName(object.getClass())), id);
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

		// PK name に含まれている文字列で検査
		for (Field field :fieldList) {
			if (field.getName().equals("no") || field.getName().indexOf("No") > -1) {
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

				// pkに合わせる
				if (fieldName.equals("no")) {
					Method setMethod = obj.getClass().getMethod("setNo", new Class[] {Integer.class});
					Object value = obj.getClass().getMethod("getNo", null).invoke(obj, null);
					if (value == null) {
						setMethod.invoke(obj, new Object[] {new Integer(1)});
					} else {
						//setMethod.invoke(obj, new Object[] {new Integer((Integer) value).intValue() + 1});
						setMethod.invoke(obj, new Object[] {new Integer((Integer) value).intValue()});
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Could not prepare '" + ClassUtils.getShortName(obj.getClass()) + "' for insert/update");
		}

	}

	// -------------------------------------------- make query name method

	/** @return Returns the select list query name. */
	protected String getSelectListQuery(String className) {
		return "get" + className + "List";
	}

	/** @return Returns the select query name. */
	protected String getSelectQuery(String className) {
        return "get" + className;
    }

	/** @return Returns the find query name. */
	protected String getFindQuery(String className) {
        return "find" + className;
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
	/** @return Returns the exists query name. */
	private String getExistsQuery(String className) {
		return "exists" + className;
	}

}
