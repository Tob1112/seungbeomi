package com.leinbow.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.leinbow.dao.UserDao;
import com.leinbow.domain.User;

@Repository("userDao")
public class UserDaoMybatis implements UserDao {

    private static final String MAPPER_PREFIX = "user.";
    private static final String SQL_ID_GET = MAPPER_PREFIX + "get";
    private static final String SQL_ID_LIST = MAPPER_PREFIX + "list";
    private static final String SQL_ID_INSERT = MAPPER_PREFIX + "insert";
    private static final String SQL_ID_UPDATE = MAPPER_PREFIX + "update";
    private static final String SQL_ID_DELETE = MAPPER_PREFIX + "delete";

    private static final String PARAMETER_NAME_ID = "id";
    private static final String PARAMETER_NAME_NAME = "name";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public User get(Long id) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAMETER_NAME_ID, id);

        return (User) sqlSession.selectOne(SQL_ID_GET, parameters);
    }

    @Override
    public List<User> list() {
        return sqlSession.selectList(SQL_ID_LIST);
    }

    @Override
    public void insert(User user) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAMETER_NAME_ID, user.getId());
        parameters.put(PARAMETER_NAME_NAME, user.getName());

        sqlSession.insert(SQL_ID_INSERT, parameters);
    }

    @Override
    public void update(User user) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAMETER_NAME_ID, user.getId());
        parameters.put(PARAMETER_NAME_NAME, user.getName());

        sqlSession.update(SQL_ID_UPDATE, parameters);
    }

    @Override
    public void delete(Long id) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(PARAMETER_NAME_ID, id);

        sqlSession.delete(SQL_ID_DELETE, parameters);
    }

}
