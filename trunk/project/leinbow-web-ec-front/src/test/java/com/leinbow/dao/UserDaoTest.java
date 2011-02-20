package com.leinbow.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.leinbow.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:test-applicationContext.xml" })
public class UserDaoTest {

    @Autowired
    private UserDao userDao;

    @Test
    public void testCrudUser() {
        assertNotNull(userDao);

        // list
        List<User> list = userDao.list();
        assertEquals(2, list.size());

        // get
        User user = userDao.get(1L);
        assertEquals("SON", user.getName());

        // insert
        user.setId(3L);
        user.setName("leinbow");

        userDao.insert(user);
        list = userDao.list();
        assertEquals(3, list.size());

        // update
        user.setName("spring");

        userDao.update(user);
        user = userDao.get(user.getId());
        assertEquals("spring", user.getName());

        // delete
        userDao.delete(user.getId());
        list = userDao.list();
        assertEquals(2, list.size());

    }

}
