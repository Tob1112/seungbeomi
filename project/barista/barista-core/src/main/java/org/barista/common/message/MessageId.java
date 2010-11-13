package org.barista.common.message;

public final class MessageId {

	public static final String BASE_MESSAGE_ID   			= "IC90";
	public static final String SQL_EXCEPTION     			= BASE_MESSAGE_ID + "001";
	public static final String CONTACT_NOT_FOUND 			= BASE_MESSAGE_ID + "002";
	public static final String FILE_NOT_FOUND    			= BASE_MESSAGE_ID + "003";
	public static final String IO_EXCEPTION      		 	= BASE_MESSAGE_ID + "004";
	public static final String MAIL_PROPERTY_IO_ERROR 	 	= BASE_MESSAGE_ID + "005";
	public static final String ALGORITHM_NOT_SUPPORTED	 	= BASE_MESSAGE_ID + "006";
	public static final String DIR_CREATION_ERROR	 		= BASE_MESSAGE_ID + "007";
}
