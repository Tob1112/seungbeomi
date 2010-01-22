package com.prms.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.TimesheetDelegate;
    import com.prms.business.events.timesheet.LoadTimesheetListEvent;
    import com.prms.model.LoginModelLocator;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.Message;
    import com.prms.views.timesheet.admin.AdminTimesheetList;
    import com.prms.vo.Timesheet;

    import mx.collections.ArrayCollection;
    import mx.collections.IViewCursor;
    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class LoadTimesheetListCommand implements ICommand {
        private var _model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var _loginModel:LoginModelLocator = LoginModelLocator.getInstance();
        private var _timesheet:Timesheet;
        private var _doc:AdminTimesheetList;

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(TimesheetListLoadResultHandler, TimesheetListLoadFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);

            if (_loginModel.account.isAdmin()) {
            	var vo:Timesheet = LoadTimesheetListEvent(event).timesheet;
            	this._doc = LoadTimesheetListEvent(event).doc;
	            delegate.getTimesheetListByComCodeAndYYYYMM(LoadTimesheetListEvent(event).timesheet);
            } else if (_loginModel.account.isUser()) {
				delegate.getTimesheetList();
            } else {
				Alert.show("勤務表リストロードに失敗しました。", "PRMS ERROR");
            }

        }

        /**
         * 勤務表一覧ロード成功の処理
         * @param event
         */
        private function TimesheetListLoadResultHandler(event:ResultEvent):void {

            if (_model.timesheetAC != null) {
                _model.timesheetAC.removeAll();
            }

            var result:ArrayCollection = event.result as ArrayCollection;

            if (result != null) {
                var cursor:IViewCursor = result.createCursor();
                var listSeq:int = 0;

                while (!cursor.afterLast) {
                    listSeq++;
                    _timesheet = cursor.current as Timesheet;
                    _model.timesheet = _timesheet;
                    _timesheet.listSeq = listSeq;
                    _model.timesheetAC.addItem(_timesheet);
                    cursor.moveNext();
                }
            }

			//会社選択ボタンを活性化
            if (_loginModel.account.isAdmin()) {
				if (!this._doc.buttonRoue.enabled) {
					this._doc.buttonRoue.enabled = true;
				}
				if (!this._doc.buttonRoueSuite.enabled) {
					this._doc.buttonRoueSuite.enabled = true;
				}
				/*
				if (!this._doc.buttonRoueLearning.enabled) {
					this._doc.buttonRoueLearning.enabled = true;
				}
				*/
            }
        }

        /**
         * 勤務表一覧ロード失敗の処理
         * @param event
         */
        private function TimesheetListLoadFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}

