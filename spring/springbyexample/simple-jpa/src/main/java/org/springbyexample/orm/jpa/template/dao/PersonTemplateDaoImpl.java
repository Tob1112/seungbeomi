/*
 * Copyright 2002-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springbyexample.orm.jpa.template.dao;


import java.util.Collection;

import javax.persistence.EntityManagerFactory;

import org.springbyexample.orm.jpa.bean.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.support.JpaDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


/**
 * Person DAO implementation.
 * 
 * @author David Winterfeldt
 */
@Repository
@Transactional(readOnly = true)
public class PersonTemplateDaoImpl extends JpaDaoSupport implements PersonTemplateDao {
    
    /**
     * Constructor
     */
    @Autowired
    public PersonTemplateDaoImpl(EntityManagerFactory entityManagerFactory) {
        super.setEntityManagerFactory(entityManagerFactory);
    }
    
    /**
     * Find persons.
     */
    @SuppressWarnings("unchecked")
    public Collection<Person> findPersons() {
        return getJpaTemplate().find("from Person");
    }
    
    /**
     * Find persons by last name.
     */
    @SuppressWarnings("unchecked")
    public Collection<Person> findPersonsByLastName(String lastName) {
        return getJpaTemplate().find("from Person p where p.lastName = ?", lastName);
    }
    
    /**
     * Saves person.
     */
    @Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
    public void save(Person person) {
        getJpaTemplate().merge(person);
    }

}
