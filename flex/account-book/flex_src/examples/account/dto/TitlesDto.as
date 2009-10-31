package examples.account.dto {
    import mx.collections.ArrayCollection;

    [RemoteClass(alias="examples.account.dto.TitlesDto")]
    public class TitlesDto {
        public var firstTitleList:ArrayCollection;

        public var secondTitleList:ArrayCollection;

        public var thirdTitleList:ArrayCollection;
    }
}