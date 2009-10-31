package examples.account {
    import examples.account.dto.Account;

    import mx.collections.ArrayCollection;
    import mx.core.IMXMLObject;

    [Bindable]
    public class RecordUpdateModel {
        public var account:Account=new Account();

        public var firstTitleList:ArrayCollection;

        public var secondTitleList:ArrayCollection;

        public var thirdTitleList:ArrayCollection;

        public function RecordUpdateModel() {
        }
    }
}