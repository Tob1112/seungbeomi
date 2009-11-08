package flora.model {

    import flora.vo.User;

    [Bindable]
    public class ModelLocator {

		public var user:User;
        static private var _instance:ModelLocator = null;

        static public function getInstance():ModelLocator {
            if (_instance == null) {
                _instance=new ModelLocator();
            }
            return _instance;
        }
    }
}