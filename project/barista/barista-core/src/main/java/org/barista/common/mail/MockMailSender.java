package org.barista.common.mail;

import java.util.logging.Logger;

import org.springframework.mail.MailSendException;

public class MockMailSender implements MailSender {

	private static final Logger log = Logger.getLogger(MockMailSender.class.getName());

	@Override
	public void send(Mail mail) throws MailSendException {
		log.fine("mail send() start. Recipient: " + mail.getRecipinet()
				+ ", Subject: " + mail.getSubject()
				+ ", Text: " + mail.getText());
		log.fine("mail send() end. sent " + mail.getRecipinet() + ".");
	}

}
