package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.ThirdTitle")]
    public class ThirdTitle {
        public var secondTitleId:int;

        public var thirdTitleId:int;

        public var thirdTitleName:String;

    }
}