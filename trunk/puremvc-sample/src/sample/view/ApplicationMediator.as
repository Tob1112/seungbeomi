package sample.view
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.model.vo.User;

    public class ApplicationMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "ApplicationMediator";

		public static const BEFORE_PANEL_VIEWSTACK:Number =	0;
		public static const AFTER_PANEL_VIEWSTACK:Number =	1;

		private var userProxy:UserProxy;

        public function ApplicationMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            facade.registerMediator(new BeforePanelMediator(app.beforePanel));
            facade.registerMediator(new AfterPanelMediator(app.afterPanel));

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
        }

		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.VIEW_BEFORE_PANEL,
				ApplicationFacade.VIEW_AFTER_PANEL
			];
		}
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.VIEW_BEFORE_PANEL:
					app.viewStack.selectedIndex = BEFORE_PANEL_VIEWSTACK;
					break;
				case  ApplicationFacade.VIEW_AFTER_PANEL:
					app.viewStack.selectedIndex = AFTER_PANEL_VIEWSTACK;
					sendNotification(ApplicationFacade.LOGIN_RESULT, note.getBody());
					break;
			}
		}

        protected function get app():main {
        	return viewComponent as main;
        }
    }
}
