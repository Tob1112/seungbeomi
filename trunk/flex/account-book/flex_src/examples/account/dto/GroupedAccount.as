package examples.account.dto {

    [RemoteClass(alias="examples.account.entity.GroupedAccount")]
    [Bindable]
    public class GroupedAccount {
        public var firstTitle:int;

        public var firstTitleName:String;

        public var secondTitle:int;

        public var secondTitleName:String;

        public var groupPrice:Number;

        public function get titleName():String {
            return firstTitleName + " - " + secondTitleName;
        }
    }
}