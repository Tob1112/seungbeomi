package sample.controller
{

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;

	import sample.model.UserProxy;

    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void
		{
            facade.registerProxy(new UserProxy());
        }
    }
}