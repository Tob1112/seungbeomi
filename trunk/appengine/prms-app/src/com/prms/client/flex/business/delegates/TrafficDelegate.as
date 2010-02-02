package com.prms.client.flex.business.delegates {
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.prms.client.flex.Constants;
	import com.prms.client.flex.vo.Traffic;
	import com.prms.client.flex.vo.TrafficRegular;

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
		 * 交通費非定期業務分合計
		 */
		public function trafficIrregAffairs(traffic:Traffic):void {

			var token:AsyncToken = _service.trafficIrregAffairs(traffic);
			token.addResponder(_responder);
		}

		/**
		 * 交通費新規作成処理
		 */
		public function trafficNewWrite(traffic:Traffic):void {

			var token:AsyncToken = _service.trafficNewWrite(traffic);
			token.addResponder(_responder);
		}

		/**
		 * 交通費合計データを取得
		 */
		public function trafficTotal(traffic:Traffic):void {
			var token:AsyncToken = _service.trafficTotal(traffic);
			token.addResponder(_responder);
		}

		/**
		 * 交通費現在日付取得
		 */
		public function trafficCurrentDate():void {
			var token:AsyncToken = _service.trafficCurrentDate();
			token.addResponder(_responder);
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

		 public function loadRegOtherList(trafficRegular:TrafficRegular):void{
		 	var token:AsyncToken = _service.loadRegOtherList(trafficRegular);
		 	token.addResponder(_responder);
		 }
	}
}