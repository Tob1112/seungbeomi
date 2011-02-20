package com.leinbow.dao.message;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.leinbow.message.LeinbowMessages;
import com.leinbow.message.MessageId;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:test-applicationContext.xml" })
public class LeinbowMessagesTest {

	@Test
	public void testGetMessage() {
		String messageId = MessageId.FILE_NOT_FOUND;
		String fileName = "spring.txt";
		String message = LeinbowMessages.getMessage(messageId, fileName);
		assertEquals("<spring.txt>ファイルが見つかりませんでした。", message);
	}

}
