package com.prms.client.flex.views.main.user.handlers {
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.events.main.UserMainHeaderEmailEvent;
    import com.prms.client.flex.business.events.main.UserMainHeaderEvent;
    import com.prms.client.flex.model.AccountModelLocator;
    import com.prms.client.flex.module.ICairngormModule;
    import com.prms.client.flex.util.LayoutSizeUtil;
    import com.prms.client.flex.views.account.user.AccountUserBody;
    import com.prms.client.flex.views.main.user.UserMainLayout;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetMain;
    import com.prms.client.flex.views.traffic.user.UserTrafficMain;

    import flash.events.MouseEvent;

    import mx.core.ContainerCreationPolicy;
    import mx.core.IMXMLObject;
    import mx.core.ScrollPolicy;
    import mx.events.FlexEvent;
    import mx.events.ModuleEvent;
    import mx.modules.ModuleLoader;

    public class UserMainLayoutHandler implements IMXMLObject{
        private var _model:AccountModelLocator = AccountModelLocator.getInstance();
        private var _document:UserMainLayout;
        private var _width:int = 0;
        private var _height:int = 0;

        public function initialized(document:Object, id:String):void {
            _document = document as UserMainLayout;
            _document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function setComponentSize():void {
            if(_width != _document.width || _height != _document.height){
                _width = _document.width;
                _height = _document.height;

                // hearder application control bar
                _document.applicationControlBar.width = LayoutSizeUtil.layoutMenuWidth(_document.width);
                _document.applicationControlBar.height = LayoutSizeUtil.layoutMenuHeight(_document.height);
                _document.applicationControlBar.visible = true;

                // contents canvas
                _document.canvas.width = LayoutSizeUtil.layoutContentWidth(_document.width);
                _document.canvas.height = LayoutSizeUtil.layoutContentHeight(_document.height);
                if(_document.moduleLoader.child != null){
                    // 勤務表
                    if(_document.moduleLoader.child is UserTimesheetMain){
                        var timesheet:UserTimesheetMain = _document.moduleLoader.child as UserTimesheetMain;
                        timesheet.width = LayoutSizeUtil.moduleWidth();
                        timesheet.height = LayoutSizeUtil.moduleHeight();
                            // 交通費
                    }else if(_document.moduleLoader.child is UserTrafficMain){
                        var traffic:UserTrafficMain = _document.moduleLoader.child as UserTrafficMain;
                        traffic.width = LayoutSizeUtil.moduleWidth();
                        traffic.height =  LayoutSizeUtil.moduleHeight();
                            // アカウント
                    }else if(_document.moduleLoader.child is AccountUserBody){
                        var account:AccountUserBody = _document.moduleLoader.child as AccountUserBody;
                        account.width = LayoutSizeUtil.moduleWidth();
                        account.height = LayoutSizeUtil.moduleWidth();
                    }
                }
            }
        }// end setComponentSize



        private function creationCompleteHandler(event:FlexEvent):void{
            // document
            _document.styleName = "outerLayout";
            _document.horizontalScrollPolicy = ScrollPolicy.OFF;
            _document.verticalScrollPolicy = ScrollPolicy.OFF;

            // hearder application control bar
            _document.applicationControlBar.visible = false;
            _document.applicationControlBar.dock = true;
            _document.applicationControlBar.creationPolicy = ContainerCreationPolicy.NONE;

            // link button -> timesheet
            _document.timesheetLinkButton.label = "勤務表";
            _document.timesheetLinkButton.width = 100;
            // link button -> traffic
            _document.trafficLinkButton.label = "交通費";
            _document.trafficLinkButton.width = 100;
            // link button -> vacation
            _document.vacationLinkButton.label = "有休";
            _document.vacationLinkButton.width = 100;
            // link button -> account
            _document.accountLinkButton.label = "アカウント";
            _document.accountLinkButton.width = 100;
            // link button -> logout
            _document.logoutLinkButton.label = "ログアウト";
            _document.logoutLinkButton.width = 100;
            // link button -> help
            _document.helpLinkButton.label = "ヘルプ";
            _document.helpLinkButton.width = 100;

            // contents canvas
            _document.canvas.styleName = "contentsLayout";
            _document.canvas.verticalScrollPolicy = ScrollPolicy.OFF;
            _document.canvas.horizontalScrollPolicy = ScrollPolicy.OFF;

            // コンポーネントのサイズ設定
            setComponentSize();

            // EventListenerに登録
            _document.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
            _document.timesheetLinkButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
            _document.trafficLinkButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
            _document.vacationLinkButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
            _document.accountLinkButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
            _document.moduleLoader.addEventListener(ModuleEvent.READY, moduleReadyHandler);
            // module loading
            _document.moduleLoader.url = Constants.USER_WORK_TIMESHEET_MAIN_SWF;

            // ヘッダユーザーメールアドレス取得
            var eventObj:UserMainHeaderEmailEvent = new UserMainHeaderEmailEvent(_document);
            eventObj.dispatch();
        }

        private function moduleReadyHandler(event:ModuleEvent):void{
            var moduleLoader:ModuleLoader = event.target as ModuleLoader;
            var module:ICairngormModule = moduleLoader.child as ICairngormModule;
            if(module != null){
                module.model = _model;
            }

            if(moduleLoader.child is UserTimesheetMain){
                var timesheet:UserTimesheetMain = moduleLoader.child as UserTimesheetMain;
                timesheet.width = LayoutSizeUtil.moduleWidth();
                timesheet.height = LayoutSizeUtil.moduleHeight();
                    // 交通費
            }else if(moduleLoader.child is UserTrafficMain){
                var traffic:UserTrafficMain = moduleLoader.child as UserTrafficMain;
                traffic.width = LayoutSizeUtil.moduleWidth();
                traffic.height =  LayoutSizeUtil.moduleHeight();
                    // アカウント
            }else if(moduleLoader.child is AccountUserBody){
                var account:AccountUserBody = moduleLoader.child as AccountUserBody;
                account.width = LayoutSizeUtil.moduleWidth();
                account.height = LayoutSizeUtil.moduleWidth();
            }
        }

        private function updateCompleteHandler(event:FlexEvent):void{
            setComponentSize();
        }

        private function mouseClickHandler(event:MouseEvent):void{
            var status:String;
            if(event.target == _document.timesheetLinkButton){
                status = Constants.STATUS_USER_TIMESHEET;
                resetDocumentSize();
            }else if(event.target == _document.trafficLinkButton){
                status = Constants.STATUS_USER_TRAFFIC;
                resetDocumentSize();
            }else if(event.target == _document.vacationLinkButton){
                status = Constants.STATUS_USER_VACATION;
                resetDocumentSize();
            }else if(event.target == _document.accountLinkButton){
                status = Constants.STATUS_USER_ACCOUNT;
                resetDocumentSize();
            }
            var eventObj:UserMainHeaderEvent = new UserMainHeaderEvent(status, _document.moduleLoader);
            eventObj.dispatch();
        }// end mouseClickHandler

        private function resetDocumentSize():void{
            _height = 0;
            _width = 0;
        }
    }
}

