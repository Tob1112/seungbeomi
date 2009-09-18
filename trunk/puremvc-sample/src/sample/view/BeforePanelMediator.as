package sample.view
{
    import flash.events.Event;

    import mx.controls.Alert;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.model.vo.User;
    import sample.view.components.AfterPanel;
    import sample.view.components.BeforePanel;

    public class BeforePanelMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "BeforePanelMediator";

		private var userProxy:UserProxy;

        public function BeforePanelMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
            beforePanel.addEventListener(BeforePanel.LOGIN, login);
        }

        private function login(event:Event = null):void {

        	userProxy.login(beforePanel.username.text, beforePanel.password.text);
	        sendNotification(ApplicationFacade.VIEW_AFTER_PANEL);
        }

        private function get beforePanel():BeforePanel {
        	return viewComponent as BeforePanel;
        }
    }
}
