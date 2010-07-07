package suite.icontact {

    import com.adobe.cairngorm.control.CairngormEvent;

    public class IContactEvent extends CairngormEvent {

        public static const LOGIN:String = "login";

        public var view:IContactView;

        public function IContactEvent(type:String, view:IContactView) {
            super(type);
            this.view = view;
        }
    }
}

