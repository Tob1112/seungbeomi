package suite.common {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;

	import suite.Constants;
	import suite.icontact.IContactModelLocator;

	public class IContactDaoCommand implements ICommand{

		private var model:IContactModelLocator = IContactModelLocator.getInstance();
		private var sqlmap:SQLMap = SQLMap.getInstance();
		private var sqlConnection:SQLConnection;

		// users table
		private static const USERNAME_COLUMN:String = ":userName";
		private static const PASSWORD_COLUMN:String = ":password";
		// contacts table
		private static const NAME_COLUMN:String = ":name";
		private static const PHONE_TYPE_COLUMN:String = ":phoneType";
		private static const PHONE_VALUE_COLUMN:String = ":phoneValue";
		private static const EMAIL_TYPE_COLUMN:String = ":emailType";
		private static const EMAIL_VALUE_COLUMN:String = ":emailValue";
		private static const ADDRESS_TYPE_COLUMN:String = ":addressType";
		private static const ADDRESS_VALUE_COLUMN:String = ":addressValue";
		private static const NOTES_COLUMN:String = ":notes";
		private static const STATUS_COLUMN:String = ":status";

		public function execute(e:CairngormEvent):void {
			switch (e.type) {
			case IContactDaoEvent.OPEN_DATABASE:
				openDatabase();
				break;

			}
		}

		private function openDatabase():void {
			var sqliteDBPath:String = Constants.PROJECT_NAME + File.separator + Constants.SYSTEM_FOLDER_NAME + File.separator + Constants.DATABASE_NAME;
            var file:File = File.userDirectory.resolvePath(sqliteDBPath);
            trace("sqlite path : " + file.nativePath);
            //var file:File = new File("app:/" + sqliteDB);
            var isNewDB:Boolean = !file.exists;
            sqlConnection = new SQLConnection();
            sqlConnection.open(file);

            if (isNewDB) {
                createDatabase();
            }
            findAll();
		}

		// TODO
		private function createDatabase():void {

			SQLMap.execute(sqlConnection, "createUsersTable");
			SQLMap.execute(sqlConnection, "createContactsTable");

			var parameters:Dictionary = new Dictionary();
			parameters[USERNAME_COLUMN] = "son";
			parameters[PASSWORD_COLUMN] = "sonpw";
			SQLMap.execute(sqlConnection, "insertUsers", parameters);

			parameters = new Dictionary();
			parameters[NAME_COLUMN] = "손승범";
			parameters[USERNAME_COLUMN] = "son";
			parameters[PHONE_TYPE_COLUMN] = "mobile";
			parameters[PHONE_VALUE_COLUMN] = "08035345232";
			parameters[EMAIL_TYPE_COLUMN] = "computer";
			parameters[EMAIL_VALUE_COLUMN] = "seungbeomi@gmail.com";
			parameters[ADDRESS_TYPE_COLUMN] = "home";
			parameters[ADDRESS_VALUE_COLUMN] = "부산 수영구 수영동 141-2";
			parameters[NOTES_COLUMN] = "개발자";
			parameters[STATUS_COLUMN] = "A";
			SQLMap.execute(sqlConnection, "insertContacts", parameters);

        }

		private function findAll():void {
			trace("findAll");
			var result:ArrayCollection = SQLMap.execute(sqlConnection, "findContacts");
			model.contactsAC = result;
		}
	}
}