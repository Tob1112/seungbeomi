package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.SecondTitle")]
    public class SecondTitle {
        public var firstTitleId:int;

        public var secondTitleId:int;

        public var secondTitleName:String;

    }
}