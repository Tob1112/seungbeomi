package com.leinbow.dao;

import java.util.List;

import com.leinbow.domain.User;

public interface UserDao {

    User get(Long id);

    List<User> list();

    void insert(User user);

    void update(User user);

    void delete(Long id);

}
