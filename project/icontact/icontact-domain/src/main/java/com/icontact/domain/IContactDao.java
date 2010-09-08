package com.icontact.domain;

import java.util.List;

public interface IContactDao {

	Contact find(Contact contact);

	List<Contact> finds(String account);

	void add(Contact contact);

	void update(Contact contact);

	void delete(Contact contact);
}
