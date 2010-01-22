package com.prms.views.traffic.common.handlers
{
	import com.prms.views.traffic.user.UserTrafficIrregCommutation;

	import mx.collections.ArrayCollection;
	import mx.core.IMXMLObject;
	import mx.events.DataGridEvent;
	import mx.events.FlexEvent;

	public class UserTrafficIrregCommutationHandler implements IMXMLObject{

		public var commutationAC:ArrayCollection;
		private var document:UserTrafficIrregCommutation;

		public function initialized(document:Object, id:String):void{
			this.document = document as UserTrafficIrregCommutation;

			this.document.addEventListener(FlexEvent.INITIALIZE, commutationInit);
			this.document.addEventListener(DataGridEvent.ITEM_EDIT_END, editCell);
		}

		public function commutationInit():void{
			commutationAC = new ArrayCollection();
			this.document.commutationDG.dataProvider = commutationAC;
		}

		private function editCell(event:DataGridEvent):void{
			var colIndex:int = event.columnIndex;

			var trainTotal:int = 0;
			this.document.trainTotalText.text = trainTotal.toString();
			var busTotal:int = 0;
			var otherTotal:int = 0;

			switch(colIndex){
				case 2:
					trainTotal = 0;

					for( var train:int=0; train<commutationAC.source.length; train++ ){
						trainTotal += this.commutationAC.getItemAt(train)["trainFare"];
						this.document.trainTotalText.text = trainTotal.toString();
					}
				break;
				case 3:
					busTotal = 0;

					for( var bus:int=0; bus<commutationAC.source.length; bus++ ){
						busTotal += this.commutationAC.getItemAt(bus)["busFare"];
						this.document.busTotalText.text = busTotal.toString();
					}
				break;
				case 4:
					otherTotal = 0;

					for( var other:int=0; other<commutationAC.source.length; other++ ){
						otherTotal += this.commutationAC.getItemAt(other)["otherIrregFare"];
						this.document.otherTotalText.text = otherTotal.toString();
					}
				break;
			}
		}
	}
}