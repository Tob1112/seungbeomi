package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.AccountBookUser")]
    public class AccountBookUser {
        public var userId:Number;

        public var password:String;

        public var userName:String;

        public var version:Number;
    }
}