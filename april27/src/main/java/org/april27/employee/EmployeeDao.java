package org.april27.employee;

import java.util.List;

import org.april27.model.Employee;

public interface EmployeeDao {

	List getAll();

	Employee get(String pk);

	void add(Employee bean);

	void update(Employee bean);

	void remove(String pk);
}
