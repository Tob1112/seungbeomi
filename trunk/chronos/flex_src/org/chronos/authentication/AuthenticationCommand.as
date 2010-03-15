package org.chronos.authentication {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import org.chronos.administration.AdministrationView;
	import org.chronos.help.HelpView;
	import org.chronos.model.AuthorizationData;
	import org.chronos.model.locator.AuthorizationDataModelLocator;
	import org.chronos.mypage.MypageView;
	import org.chronos.projects.ProjectsView;
	import org.chronos.util.AlertMessage;

	public class AuthenticationCommand implements ICommand {

		private var view:Object;
		private var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();

		public function execute(e:CairngormEvent):void {
            view = AuthenticationEvent(e).view;
            var responder:Responder = null;
            var delegate:AuthenticationDelegate = null;

            switch (e.type) {
            case AuthenticationEvent.AUTHENTICATE_USER:       // authentication
                responder = new Responder(authenticateUserResultHandler, authenticateUserFaultHandler);
                delegate = new AuthenticationDelegate(responder);
                delegate.authenticateUser(model.authorizationData);
                break;
            }
		}
        // -----------------------------------------------------------
        // authentication
        // -----------------------------------------------------------
        private function authenticateUserResultHandler(e:ResultEvent):void {
            model.authorizationData = AuthorizationData(e.result);
            CursorManager.removeBusyCursor();
            view.removeAllChildren();

            createAuthorizedView();

        }

        private function createAuthorizedView():void {

            // MENUVIEWS
            if (model.authorizationData.isAdmin()) {
                view.parentApplication.menuViews.addChild(new MypageView);
                view.parentApplication.menuViews.addChild(new ProjectsView);
                view.parentApplication.menuViews.addChild(new AdministrationView);      // admin menu
                view.parentApplication.menuViews.addChild(new HelpView);
            } else {
                view.parentApplication.menuViews.addChild(new MypageView);
                view.parentApplication.menuViews.addChild(new ProjectsView);
                view.parentApplication.menuViews.addChild(new HelpView);
            }

            // ACCOUNTBOX
            view.parentApplication.accountBox.removeAllChildren();

            var authorizedUsernameLabel:Label = new Label();
            //authorizedUserLabel.setStyle("fontWeight","bold");
            authorizedUsernameLabel.text = "Logged in as " + model.authorizationData.username;
            view.parentApplication.accountBox.addChild(authorizedUsernameLabel);

            var myAccountButton:LinkButton = new LinkButton();
            myAccountButton.label = "My account";
            view.parentApplication.accountBox.addChild(myAccountButton);

            var logOutButton:LinkButton = new LinkButton();
            logOutButton.label = "LOGOUT";
            view.parentApplication.accountBox.addChild(logOutButton);

        }

        private function authenticateUserFaultHandler(e:FaultEvent):void {
            CursorManager.removeBusyCursor();
            view.authenticationMessage.text = "problem while authentication...";
            trace(e.fault.toString());
            view.authenticationMessage.visible = true;
            view.loginButton.enabled = true;
            AlertMessage.warn(e.fault.faultString);
        }
	}
}