package org.flora.service;

import java.util.List;

import org.flora.dao.ibatis.model.Role;

public interface RoleManager extends GenericManager<Role, String> {

    public List<Role> getRoles(Role role);

    public Role getRole(String rolename);

    public void saveRole(Role role);

    public void removeRole(String rolename);

}
