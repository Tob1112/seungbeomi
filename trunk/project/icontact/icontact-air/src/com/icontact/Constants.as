package com.icontact {
	import flash.filesystem.File;


	public class Constants 	{

		public static const ICONTACT_REMOTE_OBJECT:String = "iContactRO";

    	private static const PROJECT_NAME:String = "iContact";
    	private static const SYSTEM_DIRECTORY_NAME:String = "SYSTEM";
    	private static const DATABASE_NAME:String = "icontact.db";

    	public static const SYSTEM_DIRECTORY_PATH:String = PROJECT_NAME + File.separator + SYSTEM_DIRECTORY_NAME;
    	public static const DATABASE_FILE_PATH:String = SYSTEM_DIRECTORY_PATH + File.separator + DATABASE_NAME;

    	public static const SQL_MAP_ICONTACT:String = "assets/sql-map-icontact.xml";

    	public static const NEW_LINE:String = "\n";
    	public static const EQUAL:String = "=";

    	public static const UTF8:String = "UTF-8";

    	public static const SEQUENCE_NAME:String = "icontactSeq";

    	public static const CODE_STATUS_ADD:String = "A";
    	public static const CODE_STATUS_MODIFY:String = "M";
    	public static const CODE_STATUS_DELETE:String = "D";

    	public static const FILE_MENU_IMPORT:String = "Import";
    	public static const FILE_MENU_EXPORT:String = "Export";
    	public static const FILE_MENU_SYNC:String = "Sync";

    	public static const SYNC_TIME:int = 1000;

		public static const HANKAKU_SPACE:String = " ";

    	public static const SQL_MAP:XML =
    		<sqlMap>
			<!-- ========================================== -->
			<!-- CREATE STATEMENTS 							-->
			<!-- ========================================== -->

			<sql id="createSequenceTable">
				CREATE TABLE sequence (
					seqName VARCHAR(30),
					id INTEGER
				);
			</sql>
			<sql id="createUsersTable">
				CREATE TABLE users (
					account   VARCHAR(30),
					password VARCHAR(30),
					username VARCHAR(30)
				);
		    </sql>
		    <sql id="createContactsTable">
				CREATE TABLE contacts (
					id INTEGER,
					name VARCHAR(30),
				    phone VARCHAR(20),
				    email VARCHAR(50),
				    address VARCHAR(200),
				    notes VARCHAR(500),
				    status CHAR(1)
				);
			</sql>

			<!-- ========================================== -->
			<!-- INSERT STATEMENTS 							-->
			<!-- ========================================== -->

			<sql id="insertSequence">
				INSERT INTO sequence(seqName, id)
				VALUES(:seqName, :id);
			</sql>
			<sql id="insertUsers">
				INSERT INTO users (account, password, username)
				VALUES (:account, :password, :username);
			</sql>
			<sql id="insertContact">
				INSERT INTO contacts (
					id,
					name,
					phone,
					email,
					address,
					notes,
					status
				)
				VALUES (
					:id,
					:name,
					:phone,
					:email,
					:address,
					:notes,
					:status
				);
			</sql>

			<!-- ========================================== -->
			<!-- SELECT STATEMENTS 							-->
			<!-- ========================================== -->
			<sql id="getSequence">
				SELECT id FROM sequence
				WHERE seqName = :seqName;
			</sql>
			<sql id="findAll">
				SELECT * FROM contacts;
			</sql>
			<sql id="findContact">
				SELECT * FROM contacts
				WHERE id = :id;
			</sql>
			<sql id="autoComplete">
		    	SELECT * FROM contacts
		    	WHERE name LIKE (:autocomplete);
		    </sql>

			<!-- ========================================== -->
			<!-- UPDATE STATEMENTS 							-->
			<!-- ========================================== -->
			<sql id="updateSequence">
				UPDATE sequence
				SET
					id = :id
				WHERE
					seqName = :seqName;
			</sql>
			<sql id="updateContact">
				UPDATE contacts
				SET
					name = :name,
					phone = :phone,
					email = :email,
					address = :address,
					notes = :notes,
					status = :status
				WHERE
					id = :id;
			</sql>

			<!-- ========================================== -->
			<!-- DELETE STATEMENTS 							-->
			<!-- ========================================== -->
			<sql id="deleteContact">
				DELETE FROM contacts
				WHERE id = :id;
		    </sql>
		</sqlMap>;

	}
}