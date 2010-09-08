package com.icontact.domain;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class IContactDaoTest {

	@Autowired
	private IContactDao dao;

	public Contact createDefaultContact() {
		Contact contact = new Contact();
		contact.setName("defaultName");
		contact.setPhone("1234567890");
		contact.setEmail("default@default.ne.jp");
		contact.setAddress("default address");
		contact.setNotes("default notes");
		contact.setStatus("I");
		contact.setAccount("son");

		return contact;
	}

	@Test
	public void contactCRUD() {
		assertNotNull(dao);
		Contact contact = new Contact();

		assertEquals(2, dao.finds("son").size());

		dao.add(createDefaultContact());

		assertEquals(3, dao.finds("son").size());

		contact.setAccount("son");
		contact.setName("defaultName");
		contact = dao.find(contact);

		contact.setStatus("M");
		dao.update(contact);

		contact = dao.find(contact);
		assertEquals("M", contact.getStatus());

		dao.delete(contact);
		assertEquals(2, dao.finds("son").size());
	}

}
