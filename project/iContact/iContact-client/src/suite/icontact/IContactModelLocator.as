package suite.icontact {

    import mx.collections.ArrayCollection;

    [Bindable]
    public class IContactModelLocator {

        public var user:User = new User();
        public var contact:Contact = new Contact();
        public var contactsAC:ArrayCollection = new ArrayCollection();

        static private var instance:IContactModelLocator = null;

        static public function getInstance():IContactModelLocator {
            if (instance == null) {
                instance = new IContactModelLocator();
            }
            return instance;
        }
        public static function destroy():void {
            if (instance != null) {
                instance = null;
            }
        }
    }
}

