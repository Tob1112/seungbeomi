package org.barista.common.mail;

import org.springframework.mail.MailSendException;

public interface MailSender {

	void send(Mail mail) throws MailSendException;
}
