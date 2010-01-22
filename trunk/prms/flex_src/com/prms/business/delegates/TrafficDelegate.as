package com.prms.business.delegates {
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.prms.Constants;
	import com.prms.vo.Traffic;
	import com.prms.vo.TrafficRegular;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class TrafficDelegate {
		private var _locator:ServiceLocator = ServiceLocator.getInstance();
		private var _service:RemoteObject;
		private var _responder:IResponder;

		public function TrafficDelegate(responder:IResponder) {
			if( _locator == null ){
				_locator = ServiceLocator.getInstance();
			}
			_responder = responder;
			_service = _locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);

		}

		/**
		 * 交通費ユーザーリスト取得
		 */
		public function trafficUserList():void {
			var token:AsyncToken = _service.trafficUserList();
			token.addResponder(_responder);
		}

		/**
     	 * 交通費 - 定期券、バス、その他各項目の合計金額取得
     	 * @param traffic 交通費（月）
     	 */
     	 public function loadRegTotals(traffic:Traffic):void{
     	 	var token:AsyncToken = _service.loadRegTotals(traffic);
     	 	token.addResponder(_responder);
     	 }

		/**
		 * 定期券一覧ロード
		 */
		 public function loadRegTrainList(trafficRegular:TrafficRegular):void{
		 	var token:AsyncToken = _service.loadRegTrainList(trafficRegular);
		 	token.addResponder(_responder);
		 }
	}
}