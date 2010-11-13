package org.barista.common.util;

public interface SystemProperty {

	String getProperty(String key);

	void reset();

}
