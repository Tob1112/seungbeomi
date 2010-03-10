package org.april27.home {

    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import mx.managers.CursorManager;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.april27.model.locator.EmployeeModelLocator;
    import org.april27.util.AlertMessage;

    public class HomeCommand implements ICommand {

        private var view:HomeView;

        public function execute(e:CairngormEvent):void {
        }

    }
}