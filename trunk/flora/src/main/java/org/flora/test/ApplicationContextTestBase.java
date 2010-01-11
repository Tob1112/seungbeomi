package org.flora.test;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.excel.XlsDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.operation.DatabaseOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.transaction.annotation.Transactional;

@ContextConfiguration(locations = { "classpath:org/flora/test/test-applicationContext.xml" })
@Transactional
public class ApplicationContextTestBase extends AbstractTransactionalJUnit4SpringContextTests {
	enum DataType {EXCEL, FLATXML}

	protected SimpleJdbcTemplate jdbcTemplate;

	protected DataSource dataSource;

	protected HttpServletRequest req = new MockHttpServletRequest();
	protected HttpServletResponse res = new MockHttpServletResponse();

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	}

	protected void cleanInsertFlatXmlData(String fileSource) throws Exception {
		insertData(fileSource, DataType.FLATXML, DatabaseOperation.CLEAN_INSERT);
	}
	protected void cleanInsertXlsData(String fileSource) throws Exception {
		insertData(fileSource, DataType.EXCEL, DatabaseOperation.CLEAN_INSERT);
	}

	private void insertData(String fileSource, DataType type, DatabaseOperation operation) throws Exception {
		InputStream sourceStream = new ClassPathResource(fileSource, getClass()).getInputStream();

		IDataSet dataset = null;
		if (type == DataType.EXCEL) {
			dataset = new XlsDataSet(sourceStream);
		}
		else if (type == DataType.FLATXML) {
			dataset = new FlatXmlDataSet(sourceStream);
		}

		operation.execute(
				new DatabaseConnection(DataSourceUtils.getConnection(dataSource)), dataset);
	}

	protected void insertFlatXmlData(String fileSource) throws Exception {
		insertData(fileSource, DataType.FLATXML, DatabaseOperation.INSERT);
	}

	protected void insertXlsData(String fileSource) throws Exception {
		insertData(fileSource, DataType.EXCEL, DatabaseOperation.INSERT);
	}
}