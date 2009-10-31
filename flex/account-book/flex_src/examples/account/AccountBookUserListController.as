package examples.account {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.messaging.Consumer;
    import mx.messaging.events.MessageEvent;
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class AccountBookUserListController implements IMXMLObject {
        private var view:AccountBookUserList;

        private var isFirstMessage:Boolean=false;

        public function AccountBookUserListController() {
        }

        public function initialized(document:Object, id:String):void {
            view=document as AccountBookUserList;
            view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function creationCompleteHandler(event:Event):void {
            var c:Consumer=view.consumer;
            c.destination="accountBookUserServiceChange";
            c.addEventListener(MessageEvent.MESSAGE, messageHandler);
            c.subscribe();

            findAll();
            view.startButton.addEventListener(MouseEvent.CLICK, startButtonClickHandler);
            view.endButton.addEventListener(MouseEvent.CLICK, endButtonClickHandler);
        }

        private function findAll():void {
            var token:AsyncToken=view.accountBookUserService.findAll();
            token.addResponder(new AsyncResponder(function(e:ResultEvent, obj:Object=null):void {
                    var list:ArrayCollection=e.result as ArrayCollection;
                    view.accountBookUserGrid.dataProvider=list;
                }, function(e:FaultEvent, obj:Object=null):void {
                    Alert.show("accountBookUserService.findAll() failed");
                }));
        }

        private function startButtonClickHandler(event:MouseEvent):void {
            view.notify.text="家計簿ユーザ監視が開始されました.";
            var token:AsyncToken=view.accountBookUserService.beginWatch();
            token.addResponder(new AsyncResponder(function(e:ResultEvent, obj:Object=null):void {

                }, function(e:FaultEvent, obj:Object=null):void {

                }));
        }

        private function endButtonClickHandler(event:MouseEvent):void {
            var token:AsyncToken=view.accountBookUserService.endWatch();
            token.addResponder(new AsyncResponder(function(e:ResultEvent, obj:Object=null):void {

                }, function(e:FaultEvent, obj:Object=null):void {

                }));
            view.notify.text="家計簿ユーザ監視が終了しました.";
            view.consumer.unsubscribe();
        }

        private function messageHandler(e:MessageEvent):void {
            var message:Number=e.message.body as Number;
            var array:ArrayCollection=view.accountBookUserGrid.dataProvider as ArrayCollection;
            if (array == null) {
                return;
            }
            var count:int=array.length;
            if (count != 0 && message != count) {
                view.notify.text="家計簿ユーザが変更されました.";
                findAll();
            }
        }
    }
}