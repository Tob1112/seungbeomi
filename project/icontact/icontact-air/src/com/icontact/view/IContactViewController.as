package com.icontact.view {

	import com.icontact.Constants;
	import com.icontact.model.IContactModelLocator;
	import com.icontact.model.dao.IContactDaoEvent;
	import com.icontact.model.domain.Contact;

	import flash.events.MouseEvent;
	import flash.filesystem.File;

	import mx.collections.ArrayCollection;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.core.IMXMLObject;
	import mx.core.SpriteAsset;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;

	public class IContactViewController implements IMXMLObject{

		private var view:IContactView;
		private var form:IContactForm;
		private var popup:SyncWindow;
		[Bindable] public var contacts:ArrayCollection = new ArrayCollection();
		[Bindable] public var model:IContactModelLocator = IContactModelLocator.getInstance();

		public function initialized(doc:Object, id:String):void {
            view = doc as IContactView;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);

            contacts = new ArrayCollection();
        }

        public function creationCompleteHandler(e:FlexEvent):void {
            // イベント登録
            registerEvent();
            openDatabase();
            addContactButtonClickHandler();
        }

		/** イベントを登録します。 */
        private function registerEvent():void {
        	view.addContactButton.addEventListener(MouseEvent.CLICK, addContactButtonClickHandler);
            view.contactDG.addEventListener(MouseEvent.CLICK, showContactDetailHandler);
            view.menuBar.addEventListener(MenuEvent.ITEM_CLICK, clickMenuBarHandler);
        }

        /** データをロードする */
		private function openDatabase():void {
			// システムディレクトリ生成
			var systemDir:File = File.userDirectory.resolvePath(Constants.SYSTEM_DIRECTORY_PATH);
			// システムディレクトリが存在しない場合
			if (!systemDir.exists) {
				systemDir.createDirectory();
			// システムディレクトリが存在する場合
			}
			var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.OPEN_DATABASE);
			icontactDaoEvent.dispatch();

		}

		/** contactを追加します。 */
        private function addContactButtonClickHandler(e:MouseEvent=null):void {
			//view.icontactForm.deleteButton.enabled = false;

			// search sequence
			var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.GET_MAX_SEQUENCE);
			icontactDaoEvent.dispatch();

			clearForm();

			if (model.sequence != 0) {
				view.icontactForm.controller.contact.id = model.sequence;
			}
        }

		/** contactの詳細を表示します。 */
        private function showContactDetailHandler(e:MouseEvent):void {
			if (e.target is ListBaseContentHolder || e.target is SpriteAsset) {
				return;
			}

			var contact:Contact = e.target.data as Contact;
			view.icontactForm.controller.contact = contact;
			model.sequence = contact.id;
        }

		/** 検索を行います。 */
        public function changeAutoCompleteHandler(e:Event):void {
        	if (view.autoComplete.searchText == null) return;

        	var autocomplete:String = view.autoComplete.searchText;
        	autocomplete = autocomplete.replace(Constants.HANKAKU_SPACE, "");
        	if (autocomplete.length == 0) {
				return;
        	} else {
        		model.autocompleteText = autocomplete;
        	}

        	var icontactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.AUTO_COMPLETE, view);
			icontactDaoEvent.dispatch();
        }

        public function autoCompleteItemClickHanler(e:MenuEvent):void {
        	trace("autoCompleteItemClickHanler");
        }

        private function clickMenuBarHandler(e:MenuEvent):void {

        	switch (e.label) {
			case Constants.FILE_MENU_SYNC:
				syncHandler();
				break;
        	}
        }

        private function syncHandler():void {
        	popup = PopUpManager.createPopUp(view, SyncWindow, true) as SyncWindow;
            popup.title = "サーバーと同期";
            //popup.addEventListener(FileLoadEvent.FILE_UPLOAD_EVENT, fileUploadHandler);
            PopUpManager.centerPopUp(popup);
        }

		/** フォムを空にします。 */
        private function clearForm():void {
        	view.icontactForm.controller.contact = new Contact();
        }

	}
}