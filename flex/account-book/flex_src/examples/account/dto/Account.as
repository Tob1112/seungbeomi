package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.Account")]
    [Bindable]
    public class Account {
        public var accountId:Number;

        public var txdate:Date;

        public var firstTitle:int;

        public var firstTitleName:String;

        public var secondTitle:int;

        public var secondTitleName:String;

        public var thirdTitle:String=" ";

        public var price:Number=0;

        public var userId:int;

        public var version:Number;
    }
}