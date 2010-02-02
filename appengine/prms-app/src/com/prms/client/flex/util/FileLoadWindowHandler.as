package com.prms.client.flex.util
{
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;

	public class FileLoadWindowHandler implements IMXMLObject
	{
		import mx.managers.CursorManager;
		import mx.formatters.DateFormatter;
		import com.prms.client.flex.model.TimesheetModelLocator;
		import mx.binding.utils.BindingUtils;
		import com.prms.client.flex.Constants;
		import mx.managers.PopUpManager;

		//ファイルをアップロードしたりダウンロードしたりするクラス
		private var fileUploadReference:FileReference;
		private var fileDownloadReference:FileReference;

		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();


		private var doc:FileLoadWindow;

		public function initialized(document:Object, id:String):void {
			doc = document as FileLoadWindow;
			doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		private function creationCompleteHandler(event:FlexEvent):void {
			fileUploadReference = new FileReference();
			fileDownloadReference = new FileReference();
			fileUploadReference.addEventListener(Event.SELECT, selectHandler);
			fileUploadReference.addEventListener(ProgressEvent.PROGRESS, fileUploadProgressHandler);
			fileUploadReference.addEventListener(Event.COMPLETE, completeHandler);
			doc.fileBrowseButton.addEventListener(MouseEvent.CLICK, clickFileBrowseButtonHandler);
			doc.fileUploadButton.addEventListener(MouseEvent.CLICK, clickFileUploadButtonHandler);
			doc.downloadFormButton.addEventListener(MouseEvent.CLICK, clickDownloadFormButtonHandler);
			doc.cancelButton.addEventListener(MouseEvent.CLICK, closeHandler);
			doc.addEventListener(CloseEvent.CLOSE, closeHandler);
			doc.saveUploadTimesheetButton.addEventListener(MouseEvent.CLICK, clickSaveUploadTimesheetButton);
		}
		/** ファイルアップ・ダウンロードウィンドウを閉じる */
		public function closeHandler(event:* = null):void {
			PopUpManager.removePopUp(doc);
		}

		private function clickFileBrowseButtonHandler(event:MouseEvent):void {
			var textTypes:FileFilter = new FileFilter("Excel ファイル (*.xls)", "*.xls");
			var allTypes:Array = new Array(textTypes);
			fileUploadReference.browse(allTypes);
		}

		/** ファイル選択の際、選択されたファイル名を表示 */
		private function selectHandler(event:Event):void {
			doc.fileUploadTextInput.text = fileUploadReference.name;
			doc.fileUploadButton.enabled = true;
		}

		private function completeHandler(event:Event):void {
			// parentにeventをdispatch
			doc.dispatchEvent(new FileLoadEvent(FileLoadEvent.FILE_UPLOAD_EVENT, fileUploadReference.name));
			//clickCloseHandler();
		}

		/** handle progress bar */
		private function fileUploadProgressHandler(event:ProgressEvent):void {
			doc.uploadProgressBar.setProgress(event.bytesLoaded, event.bytesTotal);
		}

		/** ファイルアップロード */
		private function clickFileUploadButtonHandler(event:MouseEvent):void {
			CursorManager.setBusyCursor();	//  cursorのステータス変更
			var request:URLRequest = new URLRequest();
			request.url = Constants.FILE_UPLOAD_URL;
			request.method = URLRequestMethod.POST;
			request.data = getURLVariables();
			fileUploadReference.upload(request);
		}

		/** ファイルダウンロード */
		private function clickDownloadFormButtonHandler(event:MouseEvent):void {
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYYMM";

			var request:URLRequest = new URLRequest();
			request.url = Constants.FILE_DOWNLOAD_URL;
			request.method = URLRequestMethod.GET;
			request.data = getURLVariables();
			var fineName:String = model.timesheet.comCode + "_" + dateFormatter.format(model.timesheet.yyyymm) + "_" + model.timesheet.lastName + model.timesheet.firstName + "_勤務表.xls";
			fileDownloadReference.download(request, fineName);
		}

		/**
		 * サーバーに送るパラメータを作成
		 * @params 会社コード、社員番号、年月
		 * */
		private function getURLVariables():URLVariables {
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYYMM";

			var params:URLVariables = new URLVariables();
			params.comCode = model.timesheet.comCode;	// 会社コード
			params.empNo = model.timesheet.empNo;	// 社員番号
			params.yyyymm = dateFormatter.format(model.timesheet.yyyymm); // 年月
			trace ("<<< params : " + model.timesheet.comCode + " - " + dateFormatter.format(model.timesheet.yyyymm) + " - " + model.timesheet.lastName + model.timesheet.firstName);
			return params;
		}

		/** 勤務表をDBに反映 */
		private function clickSaveUploadTimesheetButton(event:MouseEvent):void {
			CursorManager.setBusyCursor();	//  cursorのステータス変更
			doc.dispatchEvent(new FileLoadEvent(FileLoadEvent.FILE_SAVE_EVENT));
			closeHandler();
		}
	}
}