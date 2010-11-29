package org.chronos.domain;

import java.util.List;

public interface ShainDao {

	Shain findShain(Shain shain);	// select

	List<List> findShainAll();	// select all

	Shain saveShain(Shain shain);	// insert update

	void removeShain(Shain shain);	// delete
}
