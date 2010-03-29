package usermanager.controller
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;

	import usermanager.ApplicationFacade;
    import usermanager.model.UserManagerProxy;
    import usermanager.view.ApplicationMediator;

    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void
		{
            // Register the ApplicationMediator
             facade.registerMediator( new ApplicationMediator( note.getBody() ) );

            // Get the EmployeeProxy
            var userManagerProxy: UserManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
            userManagerProxy.getUsers();

            sendNotification( ApplicationFacade.VIEW_LOGIN );
        }
    }
}
