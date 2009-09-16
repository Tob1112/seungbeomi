package sample.view
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.view.components.AfterPanel;

    public class ApplicationMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "ApplicationMediator";

		public static const BEFORE_PANEL_VIEWSTACK:Number =	0;
		public static const AFTER_PANEL_VIEWSTACK:Number =	1;

        public function ApplicationMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            facade.registerMediator(new BeforeMediator(app.beforePanel));
            facade.registerMediator(new AfterMediator(app.afterPanel));
        }

		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.LOGIN_RESULT
			];
		}
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case  ApplicationFacade.LOGIN_RESULT:
					app.viewStack.selectedIndex = AFTER_PANEL_VIEWSTACK;
					sendNotification(AfterMediator.SHOW_AFTER_DATA, note.getBody());
				break;
			}
		}

        protected function get app():main {
        	return viewComponent as main;
        }
    }
}
