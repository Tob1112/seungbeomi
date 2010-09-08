package com.icontact.domain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class IContactServiceImpl implements IContactService {

	@Autowired
	IContactDao dao;

	@Override
	public String login(User user) {
		System.out.println("server : account - " + user.getAccount() + ", password - " + user.getPassword());
		return "SUCCESS";
	}

	@Override
	public Contact find(Contact contact) {
		return dao.find(contact);
	}

	@Override
	public List<Contact> finds(String username) {
		return dao.finds(username);
	}

	@Override
	public void add(Contact contact) {
		dao.add(contact);
	}

	@Override
	public void update(Contact contact) {
		dao.update(contact);
	}

	@Override
	public void delete(Contact contact) {
		dao.delete(contact);
	}
}
