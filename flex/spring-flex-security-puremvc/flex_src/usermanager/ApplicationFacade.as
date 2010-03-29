package usermanager
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.facade.*;
    import org.puremvc.as3.patterns.proxy.*;

    import usermanager.controller.ApplicationStartupCommand;

    public class ApplicationFacade extends Facade
    {
        // Notification name constants
        public static const STARTUP: String = "startup";
        public static const SHUTDOWN: String = "shutdown";
		public static const LOGIN: String = "login";
		public static const LOGIN_ERROR: String = "loginError";
		public static const LOGOUT: String = "logout";
		public static const LOAD_USER_SUCCESS: String = "loadUserSuccess";
		public static const LOAD_USER_FAILED: String = "loadUserFailed";
		public static const VIEW_LOGIN = "viewLogin";
		public static const VIEW_USERMANAGER = "viewUserManager";
		public static const CREATE_USER = "createUser";
		public static const UPDATE_USER = "updateUser";
		public static const DELETE_USER = "deleteUser";

        public static function getInstance() : ApplicationFacade
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller
         */
        override protected function initializeController( ) : void
        {
            super.initializeController();
            registerCommand( STARTUP, ApplicationStartupCommand );
        }

        public function startup( app:UserManager ):void
        {
        	sendNotification( STARTUP, app );
        }
    }
}
