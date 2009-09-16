package sample.controller
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;

    import sample.view.ApplicationMediator;
    import sample.view.BeforeMediator;
    import sample.view.AfterMediator;

    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void
		{
             facade.registerMediator( new ApplicationMediator( note.getBody() ) );

             var app:main = note.getBody() as main;
             facade.registerMediator( new BeforeMediator(app.beforePanel));
             facade.registerMediator( new AfterMediator(app.afterPanel));
        }
    }
}
