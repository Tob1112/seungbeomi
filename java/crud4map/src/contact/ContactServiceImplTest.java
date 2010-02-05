package contact;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

public class ContactServiceImplTest {

	private final int ORIGIN_CONTACT_SIZE = 3;
	private final int EXPECT_ADDED_SIZE = 4;

	ContactDAO dao;

	@Before
	public void setUp() {
		dao = new ContactDAOMock();
	}

	@Test
	public void testContactCRUD() {
		assertNotNull(dao);

		//SELECT
		List<Contact> listContacts = dao.listContacts();
		assertEquals(ORIGIN_CONTACT_SIZE, listContacts.size());
		printContact(listContacts);

		//SAVE
		Contact contact = new Contact("111","222","333");
		dao.addContact(contact);

		//SELECT
		List<Contact> addedLiist = dao.listContacts();
		assertEquals(EXPECT_ADDED_SIZE, addedLiist.size());
		printContact(addedLiist);

		//REMOVE
		contact.setEmail("son@gmail.com");
		dao.removeContact(contact);

		//SELECT
		List<Contact> removedLiist = dao.listContacts();
		assertEquals(ORIGIN_CONTACT_SIZE, removedLiist.size());
		printContact(removedLiist);

		//UPDATE
		contact.setEmail("222");
		contact.setName("seungbeomi");
		dao.updateContact(contact);

		//GET
		Contact updatedContact = dao.getContact(contact);
		assertEquals("seungbeomi", updatedContact.getName());

		//SELECT
		List<Contact> updatedLiist = dao.listContacts();
		assertEquals(ORIGIN_CONTACT_SIZE, updatedLiist.size());
		printContact(updatedLiist);

	}

	private void printContact(List<Contact> list) {
		System.out.println();
		System.out.println("---------------------------------------------------------------");
		for (Contact contact : list) {
			System.out.println(contact);
		}
		System.out.println("---------------------------------------------------------------");
	}
}
