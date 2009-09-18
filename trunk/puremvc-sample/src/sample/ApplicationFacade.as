package sample
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.facade.*;
    import org.puremvc.as3.patterns.proxy.*;

    import sample.controller.ApplicationStartupCommand;

    public class ApplicationFacade extends Facade
    {

        // Notification name constants
        public static const STARTUP:String = "startup";
        public static const LOGIN_RESULT:String = "loginResult";

        public static const VIEW_BEFORE_PANEL:String = "viewBeforePanel";
        public static const VIEW_AFTER_PANEL:String = "viewAfterPanel";

        public static function getInstance() : ApplicationFacade
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        override protected function initializeController( ) : void
        {
            super.initializeController();
            registerCommand( STARTUP, ApplicationStartupCommand );
        }

        public function startup( app:main ):void
        {
        	sendNotification( STARTUP, app );
        }
    }
}
