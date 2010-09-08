package com.icontact.view {

	import com.icontact.model.IContactModelLocator;
	import com.icontact.model.event.IContactEvent;

	import flash.events.Event;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class SyncWindowController implements IMXMLObject{

		private var view:SyncWindow;
		private var model:IContactModelLocator = IContactModelLocator.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as SyncWindow;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		public function creationCompleteHandler(e:FlexEvent):void {
			view.addEventListener(CloseEvent.CLOSE, closeHandler);
			view.syncChkBox.addEventListener(Event.CHANGE, toggleSyncChkBoxHandler);
		}

		private function closeHandler(e:CloseEvent):void {
			PopUpManager.removePopUp(view);
		}

		private function toggleSyncChkBoxHandler(e:Event):void {
			// サーバーと同期開始
			if (view.syncChkBox.selected) {
				view.account.enabled = false;
				view.password.enabled = false;

				model.user.account = view.account.text;
				model.user.password = view.password.text;

				var icontactEvent:IContactEvent = new IContactEvent(IContactEvent.LOGIN);
				icontactEvent.dispatch();

			// サーバーと同期解除
			} else {
				view.account.enabled = true;
				view.password.enabled = true;

				IContactModelLocator.syncTimer.stop();

			}
		}

	}
}