package com.icontact.domain;

import java.util.List;

public interface IContactService {

	String login(User user);

	Contact find(Contact contact);

	List<Contact> finds(String username);

	void add(Contact contact);

	void update(Contact contact);

	void delete(Contact contact);

}
