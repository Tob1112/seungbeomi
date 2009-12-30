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

package org.springbyexample.jdbc.datasource;

import java.sql.SQLException;

import org.apache.commons.dbcp.BasicDataSource;
import org.springbyexample.jdbc.core.SqlScriptProcessor;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;


/**
 * Initializing version of <code>BasicDataSource</code>.
 * After the properties are set any database initialization scripts are run.
 * This is very useful for unit testing.
 * 
 * @author David Winterfeldt
 * 
 * @see org.apache.commons.dbcp.BasicDataSource
 * @see org.springbyexample.jdbc.core.SqlScriptProcessor
 */
public class InitializingBasicDataSource extends BasicDataSource 
        implements InitializingBean, DisposableBean {

    protected SqlScriptProcessor sqlScriptProcessor = null;

    /**
     * Sets SQL script processor.
     */
    public void setSqlScriptProcessor(SqlScriptProcessor sqlScriptProcessor) {
        this.sqlScriptProcessor = sqlScriptProcessor;
    }

    /**
     * Implementation of <code>InitializingBean</code>
     */
    public void afterPropertiesSet() throws Exception {
        if (sqlScriptProcessor != null) {
            sqlScriptProcessor.setDataSource(this);

            sqlScriptProcessor.process();
        }
    }

    /**
     * Implementation of <code>DisposableBean</code>
     */
    public void destroy() throws Exception {
        close();
    }

    public boolean isWrapperFor(Class<?> iface) throws SQLException {
        // TODO Auto-generated method stub
        return false;
    }

    public <T> T unwrap(Class<T> iface) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }

}