package org.barista.common.mail;

import java.io.InputStream;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.*;
import javax.mail.*;

import org.apache.commons.io.IOUtils;
import org.springframework.mail.MailSendException;

import org.barista.common.mail.exception.MailRuntimeException;
import org.barista.common.message.BaristaMessages;
import org.barista.common.message.MessageId;

public class DefaultMailSender implements MailSender{

	private static final Logger log = Logger.getLogger(DefaultMailSender.class.getName());

	private static final String MAIL_PROPERTY_FILE = "mail.properties";

	private static final String CHARSET = "UTF-8";
	private static final String HEADER_NAME = "Content-Type";
	private static final String HEADER_VALUE = "text/html";

	private static final String MAIL_SMTP_HOST = "mail.smtp.host";
	private static final String MAIL_SMTP_PORT = "mail.smtp.port";
	private static final String MAIL_FROM = "mail.from";
	private static final String MAIL_NAME = "mail.name";

	private static String smtpHost;
	private static String smtpPort;
	private static String fromAddress;
	private static String fromName;
	private static boolean isReady = false;

	static {
		ClassLoader cl = null;
		InputStream in = null;
		Properties prop = new Properties();
		isReady = false;

		try {
			cl = Thread.currentThread().getContextClassLoader();
			in = cl.getResourceAsStream(MAIL_PROPERTY_FILE);
			prop.load(in);
			smtpHost = prop.getProperty(MAIL_SMTP_HOST);
			smtpPort = prop.getProperty(MAIL_SMTP_PORT);
			fromAddress = prop.getProperty(MAIL_FROM);
			fromName = prop.getProperty(MAIL_NAME);
			isReady = true;
		} catch (Exception e) {
			log.warning(BaristaMessages.getMessage(MessageId.MAIL_PROPERTY_IO_ERROR));
		} finally {
			IOUtils.closeQuietly(in);
		}

	}

	@Override
	public void send(Mail mail) throws MailSendException {
		log.fine("mail send() start. Recipient: " + mail.getRecipinet()
				+ ", Subject: " + mail.getSubject()
				+ ", Text: " + mail.getText());

		if (!isReady) {
			throw new MailRuntimeException(MessageId.MAIL_PROPERTY_IO_ERROR,
					BaristaMessages.getMessage(MessageId.MAIL_PROPERTY_IO_ERROR));
		}

		try {
			Properties prop = System.getProperties();
			prop.put(MAIL_SMTP_HOST, smtpHost);
			prop.put(MAIL_SMTP_PORT, smtpPort);
			prop.put("mail.smtp.starttle.enable", "true");
			prop.put("mail.smtp.auth", "true");
			//prop.put("mail.smtp.host", "smtp.gmail.com");
/*
			Authenticator auth = new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("seungbeomi@gmail.com", "thstmdqja79");
				}
			};
			Session session = Session.getDefaultInstance(prop, auth);
 */
			Session session = Session.getDefaultInstance(prop, null);

			session.setDebug(true);

			MimeMessage mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress(fromAddress, fromName, CHARSET));
			mimeMessage.setRecipients(Message.RecipientType.TO, mail.getRecipinet());
			mimeMessage.setSubject(mail.getSubject(), CHARSET);
			mimeMessage.setText(mail.getText(), CHARSET);
			mimeMessage.setHeader(HEADER_NAME, HEADER_VALUE);
			mimeMessage.setSentDate(new Date());
			Transport.send(mimeMessage);
			log.fine("mail send() end. sent " + mail.getRecipinet() + ".");
		} catch (Exception e) {
			throw new MailRuntimeException(MessageId.MAIL_PROPERTY_IO_ERROR,
					BaristaMessages.getMessage(MessageId.MAIL_PROPERTY_IO_ERROR));
		}
	}

}
