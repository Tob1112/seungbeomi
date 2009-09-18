package sample.controller
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;

    import sample.ApplicationFacade;
    import sample.view.ApplicationMediator;

    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void
		{
             facade.registerMediator( new ApplicationMediator( note.getBody() ) );

             // loadData
			

             // notificate main page infomation
             sendNotification(ApplicationFacade.VIEW_BEFORE_PANEL);

        }
    }
}
