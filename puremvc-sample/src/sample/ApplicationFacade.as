package sample
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.facade.*;
    import org.puremvc.as3.patterns.proxy.*;

    import sample.controller.ApplicationStartupCommand;

    public class ApplicationFacade extends Facade
    {

        public static const STARTUP:String = "startup";

        public static const VIEW_LOGIN_PANEL:String = "viewLoginPanel";
        public static const VIEW_LOGIN_RESULT_PANEL:String = "viewLoginResultPanel";

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

        public function startup( app:Main ):void
        {
        	sendNotification( STARTUP, app );
        }
    }
}
