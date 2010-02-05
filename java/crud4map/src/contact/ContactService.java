package contact;

import java.util.List;

public interface ContactService {
	public void addContact(Contact contact);
    public List<Contact> listContacts();
    public void removeContact(Contact contact);
    public void updateContact(Contact contact);
}
