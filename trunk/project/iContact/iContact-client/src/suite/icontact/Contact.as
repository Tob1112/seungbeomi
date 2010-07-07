package suite.icontact {

    [RemoteClass(alias="suite.icontact.Contact")]
    [Bindable]
    public class Contact {
        public var username:String;
        public var name:String;
        public var phoneType:String;
        public var phoneValue:int;
        public var emailType:String;
        public var emailValue:String;
        public var addressType:String;
        public var addressValue:String;
        public var status:String;
    }
}

