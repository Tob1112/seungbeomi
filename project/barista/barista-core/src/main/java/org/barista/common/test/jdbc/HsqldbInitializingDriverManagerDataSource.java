/*
 * Copyright 2002-2006 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.barista.common.test.jdbc;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;


/**
 * <p>HSQL DB specific initializing <code>DriverManagerDataSource</code>.
 * If values aren't set for driver class name, url, username, or password 
 * defaults for an in memory HSQL DB are used.</p>
 * 
 * <p>After the properties are set any database initialization scripts are run.
 * This is very useful for unit testing.</p>
 * 
 * @author David Winterfeldt
 * 
 * @see org.springframework.jdbc.datasource.DriverManagerDataSource
 */
public class HsqldbInitializingDriverManagerDataSource extends InitializingDriverManagerDataSource 
        implements InitializingBean {

    protected static String DRIVER_CLASS_NAME = "org.hsqldb.jdbcDriver";
    protected static String URL = "jdbc:hsqldb:mem:Test";
    protected static String USERNAME = "sa";
    protected static String PASSWORD = "";

    /**
     * Implementation of <code>InitializingBean</code>
     */
    public void afterPropertiesSet() throws Exception {
        if (getDriver() == null && !StringUtils.hasText(driverClassName)) {
            setDriverClass(ClassUtils.forName(DRIVER_CLASS_NAME));
        }

        if (!StringUtils.hasText(getUrl())) {
            setUrl(URL);
        }

        if (!StringUtils.hasText(getUsername())) {
            setUsername(USERNAME);
        }

        if (!StringUtils.hasText(getPassword())) {
            setPassword(PASSWORD);
        }
        
        super.afterPropertiesSet();
    }

}