package suite {

    public class Constants {

    	public static const ICONTACT_REMOTE_OBJECT:String = "iContactRO";

    	public static const PROJECT_NAME:String = "iContact";
    	public static const SYSTEM_FOLDER_NAME:String = "SYSTEM";
    	public static const INIT_FILE_NAME:String = "icontact.ini";
    	public static const DATABASE_NAME:String = "icontact.db";

    	public static const LOGIN_STATE:String = "login";
    	public static const BIG_STATE:String = "big";
    	public static const SMALL_STATE:String = "small";

    	public static const BIG_STATE_BUTTON_LABEL:String = "大";
    	public static const SMALL_STATE_BUTTON_LABEL:String = "小";

    	public static const NEW_LINE:String = "\n";
    	public static const EQUAL:String = "=";

    	public static const USERNAME:String = "username";
    	public static const PASSWORD:String = "password";
    	public static const REMEMBER_ME:String = "rememberme";



    	public static const UTF8:String = "UTF-8";

        public static const SQL_MAP:XML =
        	<sqlMap>
                <sql id="createUsersTable">
					CREATE TABLE USERS (
						USER_NAME VARCHAR(30),
						PASSWORD VARCHAR(30)
					);
                </sql>
                <sql id="createContactsTable">
					CREATE TABLE CONTACTS (
						NAME VARCHAR(30),
					    USER_NAME VARCHAR(30),
					    PHONE_TYPE CHAR(6),
					    PHONE_VALUE VARCHAR(20),
					    EMAIL_TYPE CHAR(8),
					    EMAIL_VALUE VARCHAR(50),
					    ADDRESS_TYPE CHAR(5),
					    ADDRESS_VALUE VARCHAR(200),
					    NOTES VARCHAR(500),
					    STATUS CHAR(1)
					);
                </sql>
                <sql id="insertUsers">
					INSERT INTO USERS (USER_NAME, PASSWORD) VALUES (:userName, :password)
                </sql>
                <sql id="insertContacts">
					INSERT INTO CONTACTS (
						NAME,
					    USER_NAME,
					    PHONE_TYPE,
					    PHONE_VALUE,
					    EMAIL_TYPE,
					    EMAIL_VALUE,
					    ADDRESS_TYPE,
					    ADDRESS_VALUE,
					    NOTES,
					    STATUS
					)
					VALUES (
						:name,
						:userName,
						:phoneType,
						:phoneValue,
						:emailType,
						:emailValue,
						:addressType,
						:addressValue,
						:notes,
						:status
					);
                </sql>
                <sql id="findContacts">
					SELECT * FROM CONTACTS;
                </sql>
            </sqlMap>;
    }
}

