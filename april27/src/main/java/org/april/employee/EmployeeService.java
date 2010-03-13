package org.april.employee;

import java.util.List;

import org.april.model.Employee;

public interface EmployeeService {

	List getAll();

	Employee get(String pk);

	void add(Employee bean);

	void update(Employee bean);

	void remove(String pk);

}
