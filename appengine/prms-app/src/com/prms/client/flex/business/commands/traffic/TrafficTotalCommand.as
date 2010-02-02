package com.prms.client.flex.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.TrafficTotalEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.traffic.user.UserTrafficTotals;
	import com.prms.client.flex.vo.Traffic;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficTotalCommand implements ICommand {

        private var document:UserTrafficTotals;
        private var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var traffic:Traffic;

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficTotalEvent).doc;
			var responder:Responder = new Responder(TrafficTotalResultHandler, TrafficTotalFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficTotal((event as TrafficTotalEvent).traffic);
		}

		private function TrafficTotalResultHandler(event:ResultEvent):void {

			model.traffic = event.result as Traffic;

			var Year:Number = model.traffic.yyyymm.getFullYear();
			var Month:Number = model.traffic.yyyymm.getMonth()+1;

			// 通勤分合計(通勤分定期 + 通勤分非定期)
			var commutationTotal:Number = model.traffic.regularTotal + model.traffic.commutationTotal;
			// 業務分合計(業務分交通費 + 業務分出張費)
			var affairsTotal:Number = model.traffic.affairsTrafficTotal + model.traffic.affairsTravelTotal;

			// 合計画面
			// トップメッセージ
		    this.document.selectedItemInfoLabel.text = "交通費明細書(" + Year + "年" + Month + "月分)";
		    // 現在のステータス
		    this.document.selectedItemStatusLabel.text = model.traffic.codeDetailName;

		    /** 交通費合計 */

		    // 交通費全体合計「通勤分 + 業務分」
		    this.document.trafficTotalLabel.text = model.traffic.trafficTotal.toString() + "円";
		    // 通勤分合計
		    this.document.headerCommutationTotalLabel.text = commutationTotal.toString() + "円";
		    // 業務分合計
		    this.document.headerAffairsTotalLabel.text = affairsTotal.toString() + "円";

		    /** 交通費詳細合計 */

		    // 通勤分定期合計
		    this.document.regularTotalLabel.text = model.traffic.regularTotal.toString() + "円";
		    // 通勤分非定期合計
		    this.document.commutationTotalLabel.text = model.traffic.commutationTotal.toString() + "円";
		    // 通勤分合計
		    this.document.bottomCommutationTotalLabel.text = commutationTotal.toString() + "円";

		    // 業務分交通費合計
			this.document.affairsTrafficTotalLabel.text = model.traffic.affairsTrafficTotal.toString() + "円";
			// 業務分出張費合計
			this.document.affairsTravelTotalLabel.text = model.traffic.affairsTravelTotal.toString() + "円";
			// 業務分合計
			this.document.bottomAffairsTotalLabel.text = affairsTotal.toString() + "円";
		}

		private function TrafficTotalFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
		}
	}
}