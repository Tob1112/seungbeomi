package com.springsource.greenhouse.develop.oauth;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabase;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.oauth.common.signature.SharedConsumerSecret;
import org.springframework.security.oauth.provider.ConsumerDetails;

import com.springsource.greenhouse.database.GreenhouseTestDatabaseBuilder;
import com.springsource.greenhouse.develop.AppRepository;
import com.springsource.greenhouse.develop.JdbcAppRepository;

public class AppConsumerDetailsServiceTest {

	private EmbeddedDatabase db;

	private AppConsumerDetailsService consumerDetailsService;

	@Before
	public void setUp() {
		db = new GreenhouseTestDatabaseBuilder().member().connectedApp().testData(ConcurrentMapOAuthSessionManagerTest.class).getDatabase();
		AppRepository appRepository = new JdbcAppRepository(new JdbcTemplate(db), Encryptors.noOpText());
		consumerDetailsService = new AppConsumerDetailsService(appRepository);
	}

	@After
	public void destroy() {
		if (db != null) {
			db.shutdown();
		}
	}

	@Test
	public void loadConsumerDetails() {
		ConsumerDetails details = consumerDetailsService.loadConsumerByConsumerKey("123456789");
		assertEquals("Greenhouse for the iPhone", details.getConsumerName());
		assertEquals("123456789", details.getConsumerKey());
		assertEquals("987654321", ((SharedConsumerSecret)details.getSignatureSecret()).getConsumerSecret());		
	}

}
