package contact;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ContactDAOMock implements ContactDAO {

    Map<String, Contact> map = new LinkedHashMap<String, Contact>();

    {
        map.put("son@gmail.com", new Contact("son", "son@gmail.com", "123-456-1212"));
        map.put("kim@gmail.com", new Contact("kim", "kim@gmail.com", "123-456-1213"));
        map.put("lee@gmail.com", new Contact("lee", "lee@gmail.com", "123-456-1214"));
    }

    public void addContact(Contact contact) {
        String email = contact.getEmail();
        map.put(email, contact);
    }

    public List<Contact> listContacts() {
        return Collections.unmodifiableList(new ArrayList<Contact>(map.values()));
    }

    public void removeContact(Contact contact) {
        map.remove(contact.getEmail());
    }

    public void updateContact(Contact contact) {
        map.put(contact.getEmail(), contact);
    }

	public Contact getContact(Contact contact) {
		return (Contact) map.get(contact.getEmail());
	}
}
