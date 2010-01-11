/**
 * Copyright (c) 2008 OpenSprout Team.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 */
package org.flora.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.flora.exception.FloraException;

/**
 * Reflection utls class.
 * @author Whiteship
 */
public class ReflectionUtils {

	private static Log logger = LogFactory
			.getLog(ReflectionUtils.class);

	/**
	 * find field from given class.
	 * @param clazz class
	 * @param fieldName field name.
	 * @return Field type object.
	 */
	public static Field getField(Class clazz, String fieldName) {
		return getField(clazz, fieldName, false);
	}

	/**
	 * find field from given class or given class's super class.
	 * @param clazz
	 * @param fieldName
	 * @param findInSuperClass
	 * @return
	 */
	public static Field getField(Class clazz, String fieldName, Boolean findInSuperClass) {
		Field field = null;
		try {
			field = clazz.getDeclaredField(fieldName);
		} catch (SecurityException e) {
			logger.error(clazz.getSimpleName() + " " + fieldName, e);
			throw new SecurityException(e);
		} catch (NoSuchFieldException e) {
			if (findInSuperClass){
				logger.debug(clazz.getSimpleName() + " " + fieldName, e);
				field = ReflectionUtils.getField(clazz.getSuperclass(), fieldName, findInSuperClass);
			}
			else{
				logger.error(clazz.getSimpleName() + " " + fieldName, e);
				throw new FloraException(e);
			}
		}
		return field;
	}

	/**
	 * get given object's field's value, whitch name is same with fieldname.
	 * @param clazz
	 * @param object
	 * @param fieldName
	 * @return value of the field.
	 */
	public static Object getValue(Class clazz, Object object, String fieldName) {
		return getValue(clazz, object, fieldName, false);
	}

	/**
	 * get given object's given field's value or given class's super class's field's value,
	 * whitch name is same with fieldname.
	 * @param clazz
	 * @param object
	 * @param fieldName
	 * @param findInSuperClass
	 * @return value of the field.
	 */
	public static Object getValue(Class clazz, Object object, String fieldName, Boolean findInSuperClass) {
		Field field = getField(clazz, fieldName, findInSuperClass);
		field.setAccessible(true);

		Object result = null;
		try {
			result = field.get(object);
		} catch (IllegalArgumentException e) {
			logger.error(clazz.getSimpleName() + " Ŭ������ " + fieldName
					+ " ��� ���� ���ٽ� ���� �߻�", e);
			throw new IllegalArgumentException(e);
		} catch (IllegalAccessException e) {
			logger.error(clazz.getSimpleName() + " Ŭ������ " + fieldName
					+ " ��� ���� ���ٽ� ���� �߻�", e);
			throw new FloraException(e);
		}
		return result;
	}


	/**
	 * return given class's field type, whitch name is same with fieldname.
	 * @param clazz
	 * @param fieldName
	 * @return field type.
	 */
	public static Class getType(Class clazz, String fieldName) {
		return getField(clazz, fieldName).getType();
	}

	/**
	 * return given class's field type or class's super class's field type,
	 * whitch name is same with fieldname.
	 * @param clazz
	 * @param object
	 * @param fieldName
	 * @return field type.
	 */
	public static Class getSubType(Class clazz, Object object, String fieldName) {
		Field field = getField(clazz, fieldName);
		field.setAccessible(true);

		Object realObject = null;
		try {
			realObject = field.get(object);
		} catch (IllegalArgumentException e) {
			logger.error(clazz.getSimpleName() + " " + fieldName, e);
			throw new IllegalArgumentException(e);
		} catch (IllegalAccessException e) {
			logger.error(clazz.getSimpleName() + " " + fieldName, e);
			throw new FloraException(e);
		}

		return realObject.getClass();
	}

	/**
	 * execute given class's method whitch name is same with methodName.
	 * @param clazz
	 * @param object
	 * @param methodName
	 * @return
	 */
	public static Object callMethod(Class clazz, Object object,
			String methodName) {
		List<Method> methods = Arrays.asList(clazz.getMethods());
		for (Method method : methods) {
			if (method.getName().equals(methodName))
				try {
					return method.invoke(object, null);
				} catch (IllegalArgumentException e) {
					logger.error(clazz.getSimpleName() + " " + methodName, e);
					throw new IllegalArgumentException(e);
				} catch (IllegalAccessException e) {
					logger.error(clazz.getSimpleName() + " " + methodName, e);
					throw new FloraException(e);
				} catch (InvocationTargetException e) {
					logger.error(clazz.getSimpleName() + " " + methodName, e);
					throw new FloraException(e);
				}
		}
		return null;
	}


}
