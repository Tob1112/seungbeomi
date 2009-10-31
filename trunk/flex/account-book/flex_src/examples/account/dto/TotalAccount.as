package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.TotalAccount")]
    public class TotalAccount {
        public var totalprice:String;

        public var txyear:int;

        public var txmonth:int;

    }
}