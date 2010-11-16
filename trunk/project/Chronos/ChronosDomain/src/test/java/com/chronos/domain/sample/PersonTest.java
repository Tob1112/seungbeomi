package com.chronos.domain.sample;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.unitils.reflectionassert.ReflectionAssert.assertReflectionEquals;
import static org.unitils.reflectionassert.ReflectionComparatorMode.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp.BasicDataSource;
import org.barista.common.util.ExcelLoader;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext-sample.xml"})
public class PersonTest {

	@Autowired
	private PersonDao dao;
	@Autowired
	private BasicDataSource datasource;

	/**
	 * simple crud test
	 */
	@Ignore @Test
	public void testPersonSimpleCRUD() {
		assertNotNull(dao);
		Person person;
		List<Person> expectedPeople = new ArrayList<Person>();
		List<Person> acturalPeople = new ArrayList<Person>();

		assertEquals(0, dao.list().size());

		dao.add(createDefaultPerson());
		assertEquals(1, dao.list().size());

		expectedPeople.add(createDefaultPerson());
		acturalPeople = dao.list();
		assertReflectionEquals(expectedPeople, acturalPeople, LENIENT_ORDER);	// unitils reflextion test

		person = dao.get(1);
		assertEquals("seungbeomi", person.getName());
		assertReflectionEquals(createDefaultPerson(), person);	// unitils reflextion test

		person.setName("modify");
		dao.update(person);

		person = dao.get(1);
		assertEquals("modify", person.getName());

		dao.delete(person.getId());
		assertEquals(0, dao.list().size());
	}

	//-----------------------------------------------------------------------------
	private static final String WORKBOOK_PATH 		= "testdata/Person.xls";
	private static final String TABLE_NAME_PERSON 	= "PERSON";
	private Connection connection;

	@Before
	public void setUp() throws SQLException {
		assertNotNull(datasource);
		connection = datasource.getConnection();
	}

	@After
	public void tearDown() throws SQLException {
		connection.rollback();
		connection.close();
	}

	private void loadTestData(String tableName, String sheetName) {
		ExcelLoader loader;

		loader = new ExcelLoader(connection);
		loader.load(tableName, WORKBOOK_PATH, sheetName);
	}

	private void unloadTestData(String tableName) {
		ExcelLoader loader;

		loader = new ExcelLoader(connection);
		loader.unload(tableName);
	}

	@Test
	public void testPersonDBunitCRUD() {
		List<Person> founds;

		this.unloadTestData(TABLE_NAME_PERSON);
		this.loadTestData(TABLE_NAME_PERSON, "list");

		founds = dao.list();

		assertEquals(2, founds.size());
	}

	private Person createDefaultPerson() {
		Person person = new Person();
		person.setId(1);
		person.setName("seungbeomi");
		return person;
	}
}
