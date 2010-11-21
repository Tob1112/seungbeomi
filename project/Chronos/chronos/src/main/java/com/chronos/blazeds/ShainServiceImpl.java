package com.chronos.blazeds;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.chronos.domain.Shain;
import com.chronos.domain.ShainDao;

public class ShainServiceImpl implements ShainService {

	@Autowired
	private ShainDao shainDao;


}
