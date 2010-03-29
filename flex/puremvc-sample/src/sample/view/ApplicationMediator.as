package sample.view
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.model.vo.User;
    import sample.view.components.LoginPanel;

    public class ApplicationMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "ApplicationMediator";

		public static const LOGIN_PANEL_VIEWSTACK:Number =	0;
		public static const LOGIN_RESULT_PANEL_VIEWSTACK:Number =	1;

		private var userProxy:UserProxy;

        public function ApplicationMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            facade.registerMediator(new LoginPanelMediator(app.loginPanel));
            facade.registerMediator(new LoginResultPanelMediator(app.loginResultPanel));

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
        }

		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.VIEW_LOGIN_PANEL,
				ApplicationFacade.VIEW_LOGIN_RESULT_PANEL
			];
		}
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.VIEW_LOGIN_PANEL:
					app.viewStack.selectedIndex = LOGIN_PANEL_VIEWSTACK;
					break;
				case  ApplicationFacade.VIEW_LOGIN_RESULT_PANEL:
					app.viewStack.selectedIndex = LOGIN_RESULT_PANEL_VIEWSTACK;
					break;
			}
		}

        protected function get app():Main {
        	return viewComponent as Main;
        }
    }
}
