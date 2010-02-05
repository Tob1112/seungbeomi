package contact;

import java.util.ArrayList;
import java.util.List;

public class ContactServiceImpl implements ContactService {

	private ContactDAO contactDAO = new ContactDAOMock();

    public void addContact(Contact contact) {
        contactDAO.addContact(contact);
    }

    public List<Contact> listContacts() {
        List<Contact> listContacts = contactDAO.listContacts();
        return new ArrayList<Contact> (listContacts);
    }

    public void removeContact(Contact contact) {
        contactDAO.removeContact(contact);

    }

    public void updateContact(Contact contact) {
        contactDAO.updateContact(contact);
    }


}
