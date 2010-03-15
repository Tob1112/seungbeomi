package org.chronos.employee;

import java.util.List;

import org.chronos.model.Employee;
import org.chronos.orm.ibatis.BaseDao;

public class EmployeeDaoImpl extends BaseDao implements EmployeeDao {

	public List getAll() {
		return getSqlMapClientTemplate().queryForList("getEmployees");
	}

	public Employee get(String pk) {
		return (Employee) getSqlMapClientTemplate().queryForObject("getEmployee",pk);
	}

	public void add(Employee bean) {
		getSqlMapClientTemplate().insert("addEmployee", bean);

	}

	public void update(Employee bean) {
		getSqlMapClientTemplate().update("updateEmployee", bean);
	}

	public void remove(String pk) {
		getSqlMapClientTemplate().delete("removeEmployee", pk);
	}
}
