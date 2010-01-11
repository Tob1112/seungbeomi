package org.flora.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.flora.dao.ibatis.model.TestModel;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class GenericDaoTest {

	protected final Logger logger = LoggerFactory.getLogger(GenericDao.class);
	protected static int SIZE = 2;
	protected static Integer ONE_NO = 1;
	protected static String ONE_NAME = "son";
	protected static Integer TWO_NO = 2;
	protected static String TWO_NAME = "kim";
	protected static Integer NEW_NO = 3;
	protected static String NEW_NAME = "lee";
	protected static String UPDATE_NAME = "park";
	protected static Boolean TRUE = true;
	protected static Boolean FALSE = false;
	protected static Integer NOT_EXIST_NO = 9999;

	@Autowired
	protected GenericDao genericDao;

	@Test
	public void testGetAll() {
		assertNotNull("GenericDao is null.", genericDao);

		List<TestModel> testList = genericDao.getAll(new TestModel());

		assertNotNull("TestList is null", testList);
		assertEquals("TestList size is " + SIZE, SIZE, testList.size());

		for (TestModel model : testList) {
			assertNotNull("test model is null.", model);

			if (ONE_NO.equals(model.getNo())) {
				assertEquals(ONE_NAME, model.getName());
			}
			if (TWO_NO.equals(model.getNo())) {
				assertEquals(TWO_NAME, model.getName());
			}
		}
	}
	@Test
	public void testGet() {
		assertNotNull("GenericDao is null.", genericDao);

		TestModel model = (TestModel) genericDao.get(new TestModel(), ONE_NO);

		assertNotNull("model is not null.", model);
		assertEquals(ONE_NAME, model.getName());

		model = (TestModel) genericDao.get(new TestModel(), TWO_NO);

		assertEquals(TWO_NAME, model.getName());
	}

	@Test
	public void testExists() {
		assertNotNull("GenericDao is null.", genericDao);

		Boolean result = genericDao.exists(new TestModel(), ONE_NO);
		assertNotNull("result is null.", result);
		assertEquals(TRUE, result);

		result = genericDao.exists(new TestModel(), TWO_NO);
		assertNotNull("result is null.", result);
		assertEquals(TRUE, result);

		result = genericDao.exists(new TestModel(), NOT_EXIST_NO);
		assertEquals(FALSE, result);

	}

	@Test
	public void testSave() {
		assertNotNull("GenericDao is null.", genericDao);

		TestModel model = new TestModel();
		model.setNo(NEW_NO);
		model.setName(NEW_NAME);

		genericDao.save(model);

		TestModel testModel = (TestModel) genericDao.get(new TestModel(), NEW_NO);
		assertNotNull("testModel is null.", testModel);

		if (NEW_NO.equals(testModel.getNo())) {
			assertEquals(NEW_NAME, model.getName());
		}

		model.setName(UPDATE_NAME);
		genericDao.save(model);

		testModel = (TestModel) genericDao.get(new TestModel(), NEW_NO);
		if (NEW_NO.equals(testModel.getNo())) {
			assertEquals(UPDATE_NAME, model.getName());
		}

	}

	@Test
	public void testRemove() {
		assertNotNull("GenericDao is null.", genericDao);

		Boolean exists = genericDao.exists(new TestModel(), NEW_NO);
		assertNotNull("exists is null",exists);
		assertEquals(TRUE, exists);

		genericDao.remove(new TestModel(), NEW_NO);

		exists = genericDao.exists(new TestModel(), NEW_NO);
		assertNotNull("exists is null",exists);
		assertEquals(FALSE, exists);
	}

	/*
	@Test
	public void testGetRoles() {
		fail("Not yet implemented");
	}
*/
}
