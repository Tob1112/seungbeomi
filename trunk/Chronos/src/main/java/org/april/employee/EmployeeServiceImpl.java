package org.april.employee;

import java.util.List;

import org.april.model.Employee;

public class EmployeeServiceImpl implements EmployeeService{

	private EmployeeDao employeeDao;

	public void setEmployeeDao(EmployeeDao employeeDao) {
		this.employeeDao = employeeDao;
	}

	public List getAll() {
		return employeeDao.getAll();
	}

	public Employee get(String pk) {
		return employeeDao.get(pk);
	}

	public void add(Employee bean) {
		employeeDao.add(bean);

	}

	public void update(Employee bean) {
		employeeDao.update(bean);
	}

	public void remove(String pk) {
		employeeDao.remove(pk);
	}

}
