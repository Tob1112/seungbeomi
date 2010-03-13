package org.april.home {

    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import mx.managers.CursorManager;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.april.model.locator.EmployeeModelLocator;
    import org.april.util.AlertMessage;

    public class HomeCommand implements ICommand {

        private var view:HomeView;

        public function execute(e:CairngormEvent):void {
        }

    }
}