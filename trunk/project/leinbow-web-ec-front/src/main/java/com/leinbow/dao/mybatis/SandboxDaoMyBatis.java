package com.leinbow.dao.mybatis;

import com.leinbow.domain.Sandbox;

public class SandboxDaoMyBatis extends GenericDaoMyBatis<Sandbox, Long> {

    public SandboxDaoMyBatis() {
        super(Sandbox.class);
    }


}
